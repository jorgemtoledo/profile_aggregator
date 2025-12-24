FactoryBot.define do
  factory :profile do
    name { "Octocat" }
    github_username { "octocat" }
    github_url { "https://github.com/octocat" }

    after(:create) do |profile|
      create(:profile_stat, profile:)
      create(:short_url, profile:)
    end
  end
end
