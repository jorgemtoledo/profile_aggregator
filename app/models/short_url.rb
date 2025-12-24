# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  belongs_to :profile

  validates :code, presence: true, uniqueness: true
  validates :target_url, presence: true
end
