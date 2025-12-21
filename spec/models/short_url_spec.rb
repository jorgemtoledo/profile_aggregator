require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  subject { build(:short_url) }

  describe "associations" do
    it { should belong_to(:profile) }
  end

  describe "validations" do
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
  end
end
