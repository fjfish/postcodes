require 'rspec'
require_relative '../../app/poros/postcode_fetcher'

describe 'PostcodeFetcher' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context "valid postcode" do
    it 'no spaces' do
      postcode = PostcodeFetcher.fetch("se17qd")
      expect(postcode).to be_a(PostcodeFetcher::WrappedResponse)
      expect(postcode.postcode).to eq("SE1 7QD")
    end
    it 'spaces' do
      postcode = PostcodeFetcher.fetch("se1 7qd")
      expect(postcode).to be_a(PostcodeFetcher::WrappedResponse)
      expect(postcode.postcode).to eq("SE1 7QD")
    end
  end

  context "invalid postcode" do
    it 'no spaces' do
      postcode = PostcodeFetcher.fetch("sh241aa")
      expect(postcode).to be false
    end
    it 'spaces' do
      postcode = PostcodeFetcher.fetch("sh24 1aa")
      expect(postcode).to be false
    end
  end

  # Note for our purposes testing the WrappedReponse class in detail deemed unnecessary
  # as it's a simple facade over a hash
end
