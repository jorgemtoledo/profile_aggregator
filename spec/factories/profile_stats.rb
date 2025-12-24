FactoryBot.define do
  factory :profile_stat do
    profile

    followers_count { 100 }
    following_count { 10 }
    stars_count { 50 }
    contributions_last_year { 120 }
    avatar_url { "https://avatars.githubusercontent.com/u/1" }
    organization { "@github" }
    location { "San Francisco" }
    last_scraped_at { Time.current }
  end
end
