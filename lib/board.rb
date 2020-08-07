# frozen_string_literal: true

require_relative './output.rb'
# Represents the 7 x 6 board used in the game
class Board
  include Output
  attr_reader :grid

  DIAGONAL_SEARCH_DIRECTIONS = [[-1, -1], [-1, 1], [1, -1], [1, 1]].freeze

  def initialize
    @grid = Array.new(6) { Array.new(7) { '' } }
  end

  def four_in_a_row?
    perpendicular_win?(:horizontally) || perpendicular_win?(:vertically) || diagonal_win?
  end

  def tie?
    !four_in_a_row? && @grid.flatten.none? { |cell| cell == '' }
  end

  def place_disc(disc, column)
    empty_cells_in_column = @grid.transpose[column].count { |cell| cell == '' }

    deepest_cell = 5 - (6 - empty_cells_in_column)

    @grid[deepest_cell][column] = disc
  end

  def column_not_full?(column)
    grid.transpose[column].any? { |cell| cell == '' }
  end

  def to_s
    <<~BOARD

        #{SQUARE * 20}
        #{COLUMN_HEADING_DIVIDER}
        #{COLUMN_HEADINGS}
        #{COLUMN_HEADING_DIVIDER}
        #{format_row(0)}
        #{ROW_DIVIDER}
        #{format_row(1)}
        #{ROW_DIVIDER}
        #{format_row(2)}
        #{ROW_DIVIDER}
        #{format_row(3)}
        #{ROW_DIVIDER}
        #{format_row(4)}
        #{ROW_DIVIDER}
        #{format_row(5)}
        #{ROW_DIVIDER}
      #{BOARD_FEET}#{' ' * SPACE_BETWEEN_FEET}#{BOARD_FEET}

    BOARD
  end

  private

  def cell(row, column)
    grid[row][column] if row.between?(0, 5) && column.between?(0, 6)
  end

  def find_neighbors(direction, row_index, column_index)
    if direction == :horizontally
      [cell(row_index, column_index + 1), cell(row_index, column_index + 2), cell(row_index, column_index + 3)]
    else
      [cell(row_index + 1, column_index), cell(row_index + 2, column_index), cell(row_index + 3, column_index)]
    end
  end

  def perpendicular_win?(direction)
    grid.each_with_index.any? do |row, row_index|
      row.each.with_index.any? do |current_cell, column_index|
        neighbors = find_neighbors(direction, row_index, column_index)

        current_cell != '' && neighbors.all? { |neighbor| current_cell == neighbor }
      end
    end
  end

  def diagonal_win?
    grid.each.with_index.any? do |row, row_index|
      row.each.with_index.any? do |current_cell, column_index|
        DIAGONAL_SEARCH_DIRECTIONS.any? do |row_travel, column_travel|
          neighbors = [
            cell(row_index + row_travel, column_index + column_travel),
            cell(row_index + 2 * row_travel, column_index + 2 * column_travel),
            cell(row_index + 3 * row_travel, column_index + 3 * column_travel)
          ]

          current_cell != '' && neighbors.all? { |neighbor| current_cell == neighbor }
        end
      end
    end
  end
end
