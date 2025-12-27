# frozen_string_literal: true

module Github
  class ProfileImporter
    def initialize(username, github_url)
      @username = username
      @github_url = github_url
    end

    def call
      Github::ProfileValidator.new(@username, @github_url).call

      profile_data = profile_scraper.call
      contributions = contributions_scraper.call

      profile = Profile.find_or_initialize_by(
        github_username: @username
      )

      profile.assign_attributes(
        name: profile_data[:name],
        github_url: profile_data[:github_url]
      )

      profile.save!

      generate_short_url(profile)

      profile_stat = profile.profile_stat || profile.build_profile_stat

      profile_stat.update!(
        followers_count: profile_data[:followers_count],
        following_count: profile_data[:following_count],
        stars_count: profile_data[:stars_count],
        contributions_last_year: contributions,
        avatar_url: profile_data[:avatar_url],
        location: profile_data[:location],
        organization: profile_data[:organization],
        last_scraped_at: Time.current
      )

      profile
    end

    private

    def profile_scraper
      @profile_scraper ||= Github::ProfileScraper.new(@username)
    end

    def contributions_scraper
      @contributions_scraper ||= Github::ContributionsScraper.new(@username)
    end

    # http://localhost:3000/aZ39Kd
    def generate_short_url(profile)
      return if profile.short_url.present?      

      code = ShortUrls::Generator.new.call

      profile.create_short_url!(
        code: code,
        target_url: profile.github_url
      )
    end
  end
end
