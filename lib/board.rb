# frozen_string_literal: true

# Represents the 7 x 6 board used in the game
class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(6) { Array.new(7) { ' ' } }
  end

  def four_in_a_row?
    horizontal_win? || vertical_win? || diagonal_win?
  end

  def place_disc(disc, column)
    empty_cells_in_column = @grid.transpose[column].count { |cell| cell == ' ' }

    deepest_cell = 5 - (6 - empty_cells_in_column)

    @grid[deepest_cell][column] = disc
  end

  def column_not_full?(column)
    @grid.transpose[column].any? { |cell| cell == ' ' }
  end

  private

  def cell(row, column)
    @grid[row][column] if row.between?(0, 5) && column.between?(0, 6)
  end

  def horizontal_win?
    @grid.each.with_index.any? do |row, r_index|
      row.each.with_index.any? do |current_cell, c_index|
        neighbors = [
          cell(r_index, c_index + 1),
          cell(r_index, c_index + 2),
          cell(r_index, c_index + 3)
        ]

        current_cell != ' ' && neighbors.all? { |neighbor| current_cell == neighbor }
      end
    end
  end

  def vertical_win?
    @grid.each.with_index.any? do |row, r_index|
      row.each.with_index.any? do |current_cell, c_index|
        neighbors = [
          cell(r_index + 1, c_index),
          cell(r_index + 2, c_index),
          cell(r_index + 3, c_index)
        ]

        current_cell != ' ' && neighbors.all? { |neighbor| current_cell == neighbor }
      end
    end
  end

  def diagonal_search_directions
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

  def diagonal_win?
    @grid.each.with_index.any? do |row, r_index|
      row.each.with_index.any? do |current_cell, c_index|
        diagonal_search_directions.any? do |r_travel, c_travel|
          neighbors = [
            cell(r_index + r_travel, c_index + c_travel),
            cell(r_index + 2 * r_travel, c_index + 2 * c_travel),
            cell(r_index + 3 * r_travel, c_index + 3 * c_travel)
          ]

          current_cell != ' ' && neighbors.all? { |neighbor| current_cell == neighbor }
        end
      end
    end
  end
end
