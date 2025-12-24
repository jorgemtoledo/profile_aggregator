require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:profile) }

  describe "associations" do
    it { should have_one(:profile_stat).dependent(:destroy) }
    it { should have_one(:short_url).dependent(:destroy) }
  end

   describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:github_username) }
    it { should validate_presence_of(:github_url) }

    it do
      create(:profile)
      should validate_uniqueness_of(:github_username)
    end
  end

  describe "callbacks" do
    it "creates profile_stat after creation" do
      profile = create(:profile)
      expect(profile.profile_stat).to be_present
    end
  end
end
