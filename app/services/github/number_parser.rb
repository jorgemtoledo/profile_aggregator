# frozen_string_literal: true

module Github
  class NumberParser
    def self.parse(text)
      return 0 if text.blank?

      normalized = text.strip.downcase

      case normalized
      when /k$/
        (normalized.delete("k").to_f * 1_000).to_i
      when /m$/
        (normalized.delete("m").to_f * 1_000_000).to_i
      else
        normalized.delete(",").to_i
      end
    end
  end
end