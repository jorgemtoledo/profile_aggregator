require "rails_helper"

RSpec.describe Github::ProfileImporter do
  let(:username)   { "octocat" }
  let(:github_url) { "https://github.com/octocat" }

  subject(:importer) { described_class.new(username, github_url) }

  let(:profile_data) do
    {
      name: "The Octocat",
      github_url: github_url,
      followers_count: 100,
      following_count: 10,
      stars_count: 5,
      avatar_url: "https://avatar.url",
      location: "San Francisco",
      organization: "@github"
    }
  end

  let(:contributions) { 42 }

  before do
    # Validator
    allow(Github::ProfileValidator)
      .to receive_message_chain(:new, :call)

    # Profile scraper
    allow(Github::ProfileScraper)
      .to receive(:new)
      .with(username)
      .and_return(double(call: profile_data))

    # Contributions scraper
    allow(Github::ContributionsScraper)
      .to receive(:new)
      .with(username)
      .and_return(double(call: contributions))

    # Short URL generator
    allow(ShortUrls::Generator)
      .to receive_message_chain(:new, :call)
      .and_return("aZ39Kd")
  end

  describe "#call" do
    context "when profile does not exist" do
      it "creates profile, profile_stat and short_url" do
        expect {
          importer.call
        }.to change(Profile, :count).by(1)
         .and change(ProfileStat, :count).by(1)
         .and change(ShortUrl, :count).by(1)

        profile = Profile.last

        expect(profile.github_username).to eq("octocat")
        expect(profile.name).to eq("The Octocat")
        expect(profile.github_url).to eq(github_url)

        stat = profile.profile_stat
        expect(stat.followers_count).to eq(100)
        expect(stat.following_count).to eq(10)
        expect(stat.stars_count).to eq(5)
        expect(stat.contributions_last_year).to eq(42)
        expect(stat.avatar_url).to eq("https://avatar.url")
        expect(stat.location).to eq("San Francisco")
        expect(stat.organization).to eq("@github")
        expect(stat.last_scraped_at).to be_present

        expect(profile.short_url.code).to eq("aZ39Kd")
        expect(profile.short_url.target_url).to eq(github_url)
      end
    end
  end
end
