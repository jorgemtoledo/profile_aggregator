# frozen_string_literal: true

require "nokogiri"
require "open-uri"
require "uri"

module Github
  class ProfileValidator
    BASE_HOSTS = ["github.com", "www.github.com"].freeze

    class InvalidProfile < StandardError; end

    def initialize(username, github_url)
      @username = username
      @github_url = github_url
    end

    def call
      validate_url_domain!
      validate_url_username!
      validate_profile_exists!
      true
    end

    private

    def validate_url_domain!
      uri = parsed_uri

      unless BASE_HOSTS.include?(uri.host)
        raise InvalidProfile, "URL do GitHub inválida"
      end
    rescue URI::InvalidURIError
      raise InvalidProfile, "URL do GitHub inválida"
    end

    def validate_url_username!
      url_username = extracted_username

      if url_username.blank?
        raise InvalidProfile, "URL do GitHub inválida"
      end

      if url_username.downcase != @username.downcase
        raise InvalidProfile, "Username não corresponde à URL do GitHub"
      end
    end

    def validate_profile_exists!
      html = URI.open(
        normalized_profile_url,
        "User-Agent" => "ProfileAggregatorBot/1.0"
      ).read

      doc = Nokogiri::HTML(html)

      page_username = doc.at_css("span.p-nickname")&.text&.strip

      if page_username.blank?
        raise InvalidProfile, "Usuário do GitHub não encontrado"
      end

      if page_username.downcase != @username.downcase
        raise InvalidProfile, "Username não corresponde ao perfil do GitHub"
      end
    rescue OpenURI::HTTPError
      raise InvalidProfile, "Usuário do GitHub não existe"
    end

    def parsed_uri
      @parsed_uri ||= URI.parse(@github_url)
    end

    def extracted_username
      parsed_uri.path
                .split("/")
                .reject(&:blank?)
                .first
    end

    def normalized_profile_url
      "https://github.com/#{@username}"
    end
  end
end
