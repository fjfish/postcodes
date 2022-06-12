require 'rails_helper'

RSpec.describe LsoaMatcher, type: :model do
  context "model validation" do
    let (:subject) { FactoryBot.create(:lsoa_matcher, match_strings: ["test"] ) }
    it "intialises" do
      subject
    end
    context "not null" do
      it "name" do
        subject.name = nil
        expect(subject.valid?).to be false
        expect(subject.errors[:name]).not_to be_empty
      end
      it "match_strings" do
        subject.match_strings = nil
        expect(subject.valid?).to be false
        expect(subject.errors[:match_strings]).not_to be_empty
      end
    end
    context "not empty" do
      it "match_strings" do
        subject.match_strings = []
        expect(subject.valid?).to be false
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
end
