# frozen_string_literal: true

require "nokogiri"
require "open-uri"

module Github
  class ContributionsScraper
    BASE_URL = "https://github.com"

    def initialize(username)
      @username = username
    end

    def call
      doc = Nokogiri::HTML(URI.open(contributions_url))
      extract_contributions(doc)
    end

    private

    def contributions_url
      "#{BASE_URL}/users/#{@username}/contributions"
    end

    def extract_contributions(doc)
      text = doc.at_css("h2")&.text
      return 0 unless text

      Github::NumberParser.parse(text)
    end
  end
end