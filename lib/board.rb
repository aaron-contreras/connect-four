# frozen_string_literal: true

# Represents the 7 x 6 board used in the game
class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(6) { Array.new(7) { '' } }
  end

  require 'pry'
  def four_in_a_row?
    # perpendicular_wins = [
    #   [0, 1, 2, 3],
    #   [1, 2, 3, 4],
    #   [2, 3, 4, 5],
    #   [3, 4, 5, 6]
    # ]

    # horizontal_win = @grid.any? do |row|
    #   perpendicular_wins.any? do |setup|
    #     !row[setup[0]].empty? &&
    #       row[setup[0]] == row[setup[1]] &&
    #       row[setup[1]] == row[setup[2]] &&
    #       row[setup[2]] == row[setup[3]]
    #   end
    # end

    # vertical_win = @grid.transpose.any? do |column|
    #   perpendicular_wins.any? do |setup|
    #     !column[setup[0]].empty? &&
    #       column[setup[0]] == column[setup[1]] &&
    #       column[setup[1]] == column[setup[2]] &&
    #       column[setup[2]] == column[setup[3]]
    #   end
    # end

    search_directions = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]

    @grid.each.with_index do |row, row_index|
      row.each.with_index do |cell, column_index|
        # No need to search if the cell is empty
        next if cell.empty?

        search_directions.each do |vertical_travel, horizontal_travel|
          neighbor_indexes = [
            [row_index + vertical_travel, column_index + horizontal_travel],
            [row_index + 2 * vertical_travel, column_index + 2 * horizontal_travel],
            [row_index + 3 * vertical_travel, column_index + 3 * horizontal_travel]
          ]

          # Move is out-of-bounds
          next unless neighbor_indexes.all? do |r, c|
                        r.between?(0, 5) && c.between?(0, 6)
                      end

          neighbor_cells = [
            @grid[neighbor_indexes[0].first][neighbor_indexes[0].last],
            @grid[neighbor_indexes[1].first][neighbor_indexes[1].last],
            @grid[neighbor_indexes[2].first][neighbor_indexes[2].last]
          ]

          return true if neighbor_cells.all? { |neighbor| cell == neighbor }
        end
      end
    end

    horizontal_win? || vertical_win?
  end

  def horizontal_win?
    @grid.each_index.any? do |row_index|
      perpendicular_wins.any? do |coordinates|
        line = neighbors(@grid, row_index, coordinates)
        !line.first.empty? && line.all? { |cell| line.first == cell }
      end
    end
  end

  def vertical_win?
    @grid.transpose.each_index.any? do |column_index|
      perpendicular_wins.any? do |coordinates|
        line = neighbors(@grid.transpose, column_index, coordinates)

        !line.first.empty? && line.all? { |cell| line.first == cell }
      end
    end
  end

  def neighbors(grid_setup, section_index, coordinates)
    [
      grid_setup[section_index][coordinates[0]],
      grid_setup[section_index][coordinates[1]],
      grid_setup[section_index][coordinates[2]],
      grid_setup[section_index][coordinates[3]]
    ]
  end

  def perpendicular_wins
    [
      [0, 1, 2, 3],
      [1, 2, 3, 4],
      [2, 3, 4, 5],
      [3, 4, 5, 6]
    ]
  end
end
