require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe "associations" do
    it { should belong_to(:profile) }
  end

  describe "validations" do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:target_url) }
  end
end
