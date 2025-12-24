# frozen_string_literal: true

module NumberFormatterHelper
  def human_number(number)
    return "0" if number.blank? || number == 0

    case number
    when 1_000...1_000_000
      format("%.1fk", number / 1000.0).sub(".0", "")
    when 1_000_000...1_000_000_000
      format("%.1fM", number / 1_000_000.0).sub(".0", "")
    when 1_000_000_000..
      format("%.1fB", number / 1_000_000_000.0).sub(".0", "")
    else
      number.to_s
    end
  end
end
