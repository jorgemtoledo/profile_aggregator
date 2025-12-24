FactoryBot.define do
  factory :short_url do
    profile
    code { SecureRandom.alphanumeric(6) }
    target_url { "https://github.com/octocat" }
  end
end
