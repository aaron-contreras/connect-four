# frozen_string_literal: true

module Output
  RED_DISC = "\u{1f534}"
  BLUE_DISC = "\u{1f535}"

  COLORS = {
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m",
    blue: "\e[34m"
  }

  CLEAR_FORMATTING = "\e[0m"

  def clear_screen
    print "\e[2J\e[H"
  end

  def clear_line_above
    print "\e[1A\e[K"
  end
end
