# frozen_string_literal: true

class ProfileStat < ApplicationRecord
  belongs_to :profile

  validates :followers_count, :following_count,
            :stars_count, :contributions_last_year,
            numericality: { greater_than_or_equal_to: 0 }

  validates :avatar_url, presence: true, allow_nil: true
end
