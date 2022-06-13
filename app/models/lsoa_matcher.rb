class LsoaMatcher < ApplicationRecord
  validates :name, :match_strings, presence: true
  before_validation do
    self.extra_postcodes ||= []
  end

  def has_postcode(postcode)
    check_extra(postcode) || has_match(postcode)
  end

  private

  def check_extra(postcode)
    normal(postcode).in?(normalised_extra)
  end

  def normal(postcode)
    postcode.gsub(/[[:space:]]/, "").downcase
  end

  def normalised_extra
    @normalised_extra ||= extra_postcodes.map(&method(:normal))
  end

  def has_match(postcode)
    postcode_details = PostcodeFetcher.fetch(postcode)
    return false unless postcode_details
    match_regexp.each do |re|
      return true if postcode_details.lsoa&.match?(re)
    end
    false
  end

  def match_regexp
    @match_regexp ||=
      begin
        to_re = ->(string) { Regexp.new(string, Regexp::IGNORECASE) }
        match_strings.map(&method(:normal)).map(&to_re)
      end
  end
end
