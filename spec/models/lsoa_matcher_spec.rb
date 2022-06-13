require "rails_helper"

RSpec.describe LsoaMatcher, type: :model do
  context "model validation" do
    let(:subject) { FactoryBot.create(:lsoa_matcher, match_strings: ["test"]) }
    it "intialises" do
      subject
    end
    context "not null" do
      it "name" do
        subject.name = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).not_to be_empty
      end
      it "match_strings" do
        subject.match_strings = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:match_strings]).not_to be_empty
      end
    end
    context "not empty" do
      it "match_strings" do
        subject.match_strings = []
        expect(subject).not_to be_valid
        expect(subject.errors[:match_strings]).not_to be_empty
      end
    end
    it "defaults" do
      subject
      subject.extra_postcodes = nil
      expect(subject).to be_valid
      expect(subject.extra_postcodes).to eq []
    end
  end
  context "matching" do
    let(:subject) { FactoryBot.create(:lsoa_matcher, match_strings: ["test"]) }
    context "One match string set" do
      before :each do
        postcode = double("postcode", lsoa: "test")
        allow(PostcodeFetcher).to receive(:fetch).and_return(postcode)
      end
      it "simple fail" do
        postcode = double("postcode", lsoa: "fail")
        allow(PostcodeFetcher).to receive(:fetch).and_return(postcode)
        expect(subject.has_postcode("test")).to be false
      end
      it "simple match" do
        expect(subject.has_postcode("test")).to be true
      end
      it "ignores case" do
        expect(subject.has_postcode("TeSt")).to be true
      end
      it "matches anywhere in the string" do
        expect(subject.has_postcode("some TeSt")).to be true
      end
      it "postcode not found" do
        allow(PostcodeFetcher).to receive(:fetch).and_return(false)
        expect(subject.has_postcode("some TeSt")).to be false
      end
    end
    context "Two match string set" do
      before :each do
        subject.match_strings = ["test1", "test2"]
        postcode = double("postcode", lsoa: "test2")
        allow(PostcodeFetcher).to receive(:fetch).and_return(postcode)
      end
      it "simple fail" do
        postcode = double("postcode", lsoa: "fail")
        allow(PostcodeFetcher).to receive(:fetch).and_return(postcode)
        expect(subject.has_postcode("test2")).to be false
      end
      it "simple match" do
        expect(subject.has_postcode("test2")).to be true
      end
      it "ignores case" do
        expect(subject.has_postcode("TeSt2")).to be true
      end
      it "matches anywhere in the string" do
        expect(subject.has_postcode("some TeSt2")).to be true
      end
      it "still matches first item" do
        postcode = double("postcode", lsoa: "test1")
        allow(PostcodeFetcher).to receive(:fetch).and_return(postcode)
        expect(subject.has_postcode("test1")).to be true
      end
    end
  end
  context "extra postcodes" do
    let(:subject) { FactoryBot.create(:lsoa_matcher, match_strings: ["nope"], extra_postcodes: %w[test1 test2]) }
    context "One match string set" do
      before :each do
        expect(PostcodeFetcher).not_to receive(:fetch)
      end
      it "matches saved no spaces" do
        expect(subject.has_postcode("test1")).to be true
        expect(subject.has_postcode("test2")).to be true
      end
      it "matches saved with spaces" do
        expect(subject.has_postcode("test 1")).to be true
        expect(subject.has_postcode("test 2")).to be true
      end
    end
  end
end
