# frozen_string_literal: true

# Represents the 7 x 6 board used in the game
class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(6) { Array.new(7) { '' } }
  end

  def four_in_a_row?
    horizontal_win? || vertical_win? || diagonal_win?
  end

  def place_disc(disc, column)
    empty_cells_in_column = @grid.transpose[column].count(&:empty?)

    deepest_cell = 5 - (6 - empty_cells_in_column)

    @grid[deepest_cell][column] = disc
  end

  private

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

  def diagonal_win?
    search_directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

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

          # Four-in-a-row found
          return true if neighbor_cells.all? { |neighbor| cell == neighbor }
        end
      end
    end

    # No four-in-a-rows found
    false
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
