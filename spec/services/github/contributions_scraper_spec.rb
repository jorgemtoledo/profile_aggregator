require "rails_helper"

RSpec.describe Github::ContributionsScraper do
  subject(:scraper) { described_class.new(username) }

  let(:username) { "octocat" }

  let(:html_with_contributions) do
    <<~HTML
      <html>
        <body>
          <h2 class="f4 text-normal mb-2">
            123 contributions in the last year
          </h2>
        </body>
      </html>
    HTML
  end

  let(:html_without_contributions) do
    <<~HTML
      <html>
        <body>
          <h2 class="f4 text-normal mb-2">
            No contributions
          </h2>
        </body>
      </html>
    HTML
  end

  before do
    allow(URI)
      .to receive(:open)
      .with("https://github.com/users/#{username}/contributions")
      .and_return(StringIO.new(html))
  end

  describe "#call" do
    context "when contributions are found" do
      let(:html) { html_with_contributions }

      it "returns contributions count" do
        expect(scraper.call).to eq(123)
      end
    end

    context "when no contributions found" do
      let(:html) { html_without_contributions }

      it "returns zero" do
        expect(scraper.call).to eq(0)
      end
    end
  end
end
