# frozen_string_literal: true

require "rails_helper"

RSpec.describe Github::NumberParser do
  describe ".parse" do
    it "parses plain numbers" do
      expect(described_class.parse("123")).to eq(123)
    end

    it "parses thousands with k" do
      expect(described_class.parse("2.6k")).to eq(2600)
      expect(described_class.parse("15k")).to eq(15000)
    end

    it "parses millions with M" do
      expect(described_class.parse("1.2M")).to eq(1_200_000)
    end

    it "returns zero for blank values" do
      expect(described_class.parse(nil)).to eq(0)
      expect(described_class.parse("")).to eq(0)
    end
  end
end
