# frozen_string_literal: true

class Profile < ApplicationRecord
  has_one :profile_stat, dependent: :destroy
  has_one :short_url, dependent: :destroy

  validates :name, presence: true
  validates :github_username, presence: true, uniqueness: true
  validates :github_url, presence: true
end
