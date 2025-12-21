FactoryBot.define do
  factory :short_url do
    association :profile
    code { SecureRandom.alphanumeric(8) }
  end
end
