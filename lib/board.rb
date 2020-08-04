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

  def to_s
    <<~BOARD
       - - - - - - -
      |#{@grid[0][0]} #{@grid[0][1]} #{@grid[0][3]} #{@grid[0][4]} #{@grid[0][5]} #{@grid[0][6]}         |
      |#{@grid[1][0]} #{@grid[1][1]} #{@grid[1][3]} #{@grid[1][4]} #{@grid[1][5]} #{@grid[1][6]}         |
      |#{@grid[2][0]} #{@grid[2][1]} #{@grid[2][3]} #{@grid[2][4]} #{@grid[2][5]} #{@grid[2][6]}         |
      |#{@grid[3][0]} #{@grid[3][1]} #{@grid[3][3]} #{@grid[3][4]} #{@grid[3][5]} #{@grid[3][6]}         |
      |#{@grid[4][0]} #{@grid[4][1]} #{@grid[4][3]} #{@grid[4][4]} #{@grid[4][5]} #{@grid[4][6]}         |
      |#{@grid[5][0]} #{@grid[5][1]} #{@grid[5][3]} #{@grid[5][4]} #{@grid[5][5]} #{@grid[5][6]}         |
    BOARD
  end

  private

  def cell(row, column)
    @grid[row][column] if row.between?(0, 5) && column.between?(0, 6)
  end

  def horizontal_win?
    @grid.each.with_index.any? do |row, r_index|
      row.each.with_index.any? do |current_cell, c_index|
        current_cell != '' &&
          current_cell == cell(r_index, c_index + 1) &&
          current_cell == cell(r_index, c_index + 2) &&
          current_cell == cell(r_index, c_index + 3)
      end
    end
  end

  def vertical_win?
    @grid.transpose.each_index.any? do |column_index|
      perpendicular_wins.any? do |coordinates|
        line = perpendicular_neighbors(@grid.transpose, column_index, coordinates)

        !line.first.empty? && line.all? { |cell| line.first == cell }
      end
    end
  end

  def diagonal_win?
    @grid.each.with_index do |row, row_index|
      row.each.with_index do |cell, column_index|
        # No need to search if the cell is empty
        next if cell.empty?

        diagonal_search_directions.each do |y_travel, x_travel|
          neighbor_coords = [
            [row_index + y_travel, column_index + x_travel],
            [row_index + 2 * y_travel, column_index + 2 * x_travel],
            [row_index + 3 * y_travel, column_index + 3 * x_travel]
          ]

          next unless neighbors_are_inbound?(neighbor_coords)

          # Four-in-a-row found
          return true if diagonal_neighbors(neighbor_coords).all? { |neighbor| cell == neighbor }
        end
      end
    end

    # No four-in-a-rows found
    false
  end

  def perpendicular_neighbors(grid_setup, section_index, coordinates)
    [
      grid_setup[section_index][coordinates[0]],
      grid_setup[section_index][coordinates[1]],
      grid_setup[section_index][coordinates[2]],
      grid_setup[section_index][coordinates[3]]
    ]
  end

  def perpendicular_wins
    [[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]]
  end

  def diagonal_search_directions
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

  def diagonal_neighbors(coordinates)
    coordinates.map do |coordinate|
      @grid[coordinate[0]][coordinate[1]]
    end
  end

  def neighbors_are_inbound?(neighbor_coords)
    farthest = neighbor_coords.last
    (farthest[0]).between?(0, 5) && (farthest[1]).between?(0, 6)
  end
end
