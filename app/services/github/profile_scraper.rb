# frozen_string_literal: true

require "nokogiri"
require "open-uri"

module Github
  class ProfileScraper
    BASE_URL = "https://github.com"

    def initialize(username)
      @username = username
    end

    def call
      html = URI.open(
        profile_url,
        "User-Agent" => "Mozilla/5.0 (compatible; ProfileAggregatorBot/1.0)"
      ).read

      doc = Nokogiri::HTML(html)

      {
        name: name(doc),
        avatar_url: avatar_url(doc),
        followers_count: followers_count(doc),
        following_count: following_count(doc),
        stars_count: stars_count(doc),
        location: location(doc),
        organization: organization(doc),
        github_url: profile_url
      }
    end

    private

    def profile_url
      "#{BASE_URL}/#{@username}"
    end

    def name(doc)
      doc.at_css("span.p-name")&.text&.strip
    end

    def avatar_url(doc)
      doc.at_css("img.avatar-user")&.attr("src")
    end

    def followers_count(doc)
      text = doc.css("a[href$='?tab=followers'] span.text-bold").text
      Github::NumberParser.parse(text)
    end

    def following_count(doc)
      text = doc.css("a[href$='?tab=following'] span.text-bold").text
      Github::NumberParser.parse(text)
    end

    def stars_count(doc)
      doc.at_css("a[href$='?tab=stars'] span.Counter")&.text&.strip&.then do |text|
        NumberParser.parse(text)
      end || 0
    end

    def location(doc)
      doc.at_css("li[itemprop='homeLocation'] span")&.text&.strip
    end

    def organization(doc)
      doc.at_css("li[itemprop='worksFor'] span")&.text&.strip
    end
  end
end