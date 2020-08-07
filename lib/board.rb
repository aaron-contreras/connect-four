# frozen_string_literal: true

# Represents the 7 x 6 board used in the game
class Board
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
    square = "\e[47m  \e[0m"
    <<~BOARD

        #{square * 20}
        #{square}|==================================|#{square}
        #{square}| \e[32m\u24b6    \u24b7    \u24b8    \u24b9    \u24ba    \u24bb    \u24bc\e[0m  |#{square}
        #{square}|==================================|#{square}
        #{square}|#{formatted_row(0)}|#{square}
        #{square}|----+----+----+----+----+----+----|#{square}
        #{square}|#{formatted_row(1)}|#{square}
        #{square}|----+----+----+----+----+----+----|#{square}
        #{square}|#{formatted_row(2)}|#{square}
        #{square}|----+----+----+----+----+----+----|#{square}
        #{square}|#{formatted_row(3)}|#{square}
        #{square}|----+----+----+----+----+----+----|#{square}
        #{square}|#{formatted_row(4)}|#{square}
        #{square}|----+----+----+----+----+----+----|#{square}
        #{square}|#{formatted_row(5)}|#{square}
        #{square}|----+----+----+----+----+----+----|#{square}
      #{square}#{square}#{square}                                #{square}#{square}#{square}

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

  def formatted_row(row)
    row = grid[row].map { |cell| cell == '' ? '  ' : "#{cell} " }

    " #{row[0]} | #{row[1]} | #{row[2]} | #{row[3]} | #{row[4]} | #{row[5]} | #{row[6]} "
  end
end
