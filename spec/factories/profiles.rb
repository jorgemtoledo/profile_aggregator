FactoryBot.define do
  factory :profile do
    username { Faker::Internet.username }
    followers_count { Faker::Number.between(from: 0, to: 10_000) }
    following_count { Faker::Number.between(from: 0, to: 5_000) }
    stars_count { Faker::Number.between(from: 0, to: 50_000) }
    contributions_last_year { Faker::Number.between(from: 0, to: 3_000) }
    avatar_url { Faker::Avatar.image }
    organization { Faker::Company.name }
    location { Faker::Address.city }
  end
end
