require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:profile) }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:avatar_url) }

    it { should validate_numericality_of(:followers_count).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:following_count).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:stars_count).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:contributions_last_year).is_greater_than_or_equal_to(0) }
  end
end
