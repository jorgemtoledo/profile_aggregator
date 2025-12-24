# frozen_string_literal: true

module ShortUrls
  class Generator
    CODE_LENGTH = 6
    CHARSET = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a

    def call
      code = generate_unique_code
    end

    private

    def generate_unique_code
      loop do
        code = Array.new(CODE_LENGTH) { CHARSET.sample }.join
        break code unless ShortUrl.exists?(code: code)
      end
    end
  end
end
