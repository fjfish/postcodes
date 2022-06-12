class LsoaMatcher < ApplicationRecord
  validates :name, :match_strings, presence: true
  before_validation do
    self.extra_postcodes ||= []
  end
end
