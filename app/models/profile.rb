class Profile < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :avatar_url, presence: true

  validates :followers_count,
            :following_count,
            :stars_count,
            :contributions_last_year,
            numericality: { greater_than_or_equal_to: 0 }
end
