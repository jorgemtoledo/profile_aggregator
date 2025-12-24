require 'rails_helper'

RSpec.describe ProfileStat, type: :model do
  
   describe "associations" do
    it { should belong_to(:profile) }
  end

  describe "validations" do
    it { should validate_numericality_of(:followers_count).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:following_count).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:stars_count).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:contributions_last_year).is_greater_than_or_equal_to(0) }
  end
end
