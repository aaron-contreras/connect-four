# frozen_string_literal: true

require 'colorize'

# Constants and methods for prettier terminal output
module Output
  RED_DISC = "\u{1f534}"
  BLUE_DISC = "\u{1f535}"

  def clear_screen
    system 'clear'
  end

  def clear_line_above
    print "\e[1A\e[K"
  end

  # Board related
  GRID_WIDTH = 34
  COLUMNS = 7
  ROWS = 6
  SPACE_BETWEEN_FEET = GRID_WIDTH - 2

  SQUARE = '  '.colorize(background: :white)

  CIRCLED_LETTERS = {
    a: "\u24b6",
    b: "\u24b7",
    c: "\u24b8",
    d: "\u24b9",
    e: "\u24ba",
    f: "\u24bb",
    g: "\u24bc"
  }.freeze

  COLUMN_HEADINGS = "#{SQUARE}| #{CIRCLED_LETTERS.map { |_k, v| v }.join(' ' * 4).green}  |#{SQUARE}"

  COLUMN_HEADING_DIVIDER = "#{SQUARE}|#{'=' * GRID_WIDTH}|#{SQUARE}"
  ROW_DIVIDER = "#{SQUARE}|#{COLUMNS.times.map { '----' }.join('+')}|#{SQUARE}"
  BOARD_FEET = SQUARE * 3

  def format_row(row)
    row = grid[row].map { |cell| cell == '' ? '  ' : "#{cell} " }.join(' | ')
    "#{SQUARE}| #{row} |#{SQUARE}"
  end
end
