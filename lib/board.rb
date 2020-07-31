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

    horizontal_win || vertical_win
  end
end
