FactoryBot.define do
  factory :lsoa_matcher do
    name { "LSOA Matcher" }
    match_strings { [] }
    extra_postcodes { [] }
  end
end
