# frozen_string_literal: true

# Represents the 7 x 6 board used in the game
class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(6) { Array.new(7) { '' } }
  end

  def four_in_a_row?
    perpendicular_wins = [
      [0, 1, 2, 3],
      [1, 2, 3, 4],
      [2, 3, 4, 5],
      [3, 4, 5, 6]
    ]

    horizontal_win = @grid.any? do |row|
      perpendicular_wins.any? do |setup|
        !row[setup[0]].empty? &&
          row[setup[0]] == row[setup[1]] &&
          row[setup[1]] == row[setup[2]] &&
          row[setup[2]] == row[setup[3]]
      end
    end

    vertical_win = @grid.transpose.any? do |row|
      perpendicular_wins.any? do |setup|
        !row[setup[0]].empty? &&
          row[setup[0]] == row[setup[1]] &&
          row[setup[1]] == row[setup[2]] &&
          row[setup[2]] == row[setup[3]]
      end
    end

    search_directions = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]

    @grid.each.with_index do |row, row_index|
      row.each_index do |column_index|
        cell = @grid[row_index][column_index]

        unless cell.empty?
          search_directions.each do |vertical_travel, horizontal_travel|
            indexes_of_cells_in_direction = [
              [row_index + vertical_travel, column_index + horizontal_travel],
              [row_index + 2 * vertical_travel, column_index + 2 * horizontal_travel],
              [row_index + 3 * vertical_travel, column_index + 3 * horizontal_travel]
            ]
            if indexes_of_cells_in_direction.all? do |r, c|
              r.between?(0, 5) && c.between?(0, 6)
            end
              if cell == @grid[indexes_of_cells_in_direction[0].first][indexes_of_cells_in_direction[0].last] &&
                cell == @grid[indexes_of_cells_in_direction[1].first][indexes_of_cells_in_direction[1].last] &&
                cell == @grid[indexes_of_cells_in_direction[2].first][indexes_of_cells_in_direction[2].last]
                return true
              end
            end
          end
        end
      end
    end

    horizontal_win || vertical_win
  end
end
