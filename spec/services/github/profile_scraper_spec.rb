require "rails_helper"

RSpec.describe Github::ProfileScraper do
  subject(:scraper) { described_class.new(username) }

  let(:username) { "octocat" }

  let(:html) do
    <<~HTML
      <html>
        <body>
          <span class="p-name">The Octocat</span>

          <img class="avatar-user" src="https://avatar.url" />

          <a href="/octocat?tab=followers">
            <span class="text-bold">100</span>
          </a>

          <a href="/octocat?tab=following">
            <span class="text-bold">10</span>
          </a>

          <a href="/octocat?tab=stars">
            <span class="Counter">5</span>
          </a>

          <li itemprop="homeLocation">
            <span>San Francisco</span>
          </li>

          <li itemprop="worksFor">
            <span>@github</span>
          </li>
        </body>
      </html>
    HTML
  end

  before do
    allow(URI)
      .to receive(:open)
      .and_return(StringIO.new(html))
  end

  describe "#call" do
    it "returns normalized profile data" do
      result = scraper.call

      expect(result[:name]).to eq("The Octocat")
      expect(result[:avatar_url]).to eq("https://avatar.url")
      expect(result[:followers_count]).to eq(100)
      expect(result[:following_count]).to eq(10)
      expect(result[:stars_count]).to eq(5)
      expect(result[:location]).to eq("San Francisco")
      expect(result[:organization]).to eq("@github")
      expect(result[:github_url]).to eq("https://github.com/octocat")
    end
  end
end
