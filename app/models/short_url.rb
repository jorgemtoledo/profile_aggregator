class ShortUrl < ApplicationRecord
  belongs_to :profile

  validates :code, presence: true, uniqueness: true
end
