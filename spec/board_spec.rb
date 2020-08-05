# frozen_string_literal: true

require_relative '../lib/board.rb'

# rubocop: disable Metrics/BlockLength
describe Board do
  subject(:board) { described_class.new }

  it 'has 6 rows' do
    # Act
    rows = board.grid.size

    # Assert
    expect(rows).to eq 6
  end

  it 'has 7 columns' do
    # Act
    columns = board.grid[0].size

    # Assert
    expect(columns).to eq 7
  end

  describe 'four_in_a_row?' do
    context 'when grid is empty' do
      it 'returns false' do
        # Act
        status = board.four_in_a_row?

        # Assert
        expect(status).to be false
      end
    end

    context 'horizontally' do
      context 'when four-in-a-row on top row' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['x', 'x', 'x', 'x', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
          ]
          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          status = board.four_in_a_row?  

          # Assert
          expect(status).to eq true
        end
      end

      context 'when four-in-a-row on bottom row' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['x', 'x', 'x', 'x', '', '', '']
          ]
          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to eq true
        end
      end

      context 'when not in an edge' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', 'x', 'x', 'x', 'x', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['x', '', 'x', 'x', '', '', '']
          ]
          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to eq true

        end
      end
    end

    context 'vertically' do
      context 'when four-in-a-row on left-most column' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['x', '', '', '', '', '', ''],
            ['x', '', '', '', '', '', ''],
            ['x', '', '', '', '', '', ''],
            ['x', '', '', '', '', '', ''],
            ['', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '']
          ]
          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to eq true
        end
      end

      context 'when four-in-a-row on right-most column' do
        it 'returns true' do
          # Arrange
          board_arrangment = [
            ['x', '', '', '', '', '', ''],
            ['x', '', '', '', '', '', 'x'],
            ['x', '', '', '', '', '', 'x'],
            ['', '', '', '', '', '', 'x'],
            ['', '', '', '', '', '', 'x'],
            ['', '', '', '', '', '', '']
          ]

          board.instance_variable_set(:@grid, board_arrangment)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to eq true
        end
      end

      context 'when not in an edge' do
        it 'returns true' do
          # Arrange
          board_arrangment = [
            ['x', '', '', '', '', '', ''],
            ['x', '', '', 'x', '', '', ''],
            ['x', '', '', 'x', '', '', ''],
            ['', '', '', 'x', '', '', ''],
            ['', '', '', 'x', '', '', ''],
            ['', '', '', '', '', '', '']
          ]

          board.instance_variable_set(:@grid, board_arrangment)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to eq true
        end
      end
    end

    context 'diagonally' do
      context 'when starting from top-left-corner' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['x', '', '', '', '', '', ''],
            ['o', 'x', '', '', '', '', 'o'],
            ['o', '', 'x', '', '', '', 'x'],
            ['', '', '', 'x', '', '', 'x'],
            ['', '', '', '', '', '', 'x'],
            ['', '', '', '', '', '', '']
          ]

          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to eq true
        end
      end

      context 'when starting from bottom-right-corner' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['x', '', '', '', '', '', ''],
            ['o', 'x', '', '', '', '', 'o'],
            ['o', '', 'x', 'x', '', '', 'o'],
            ['', '', '', 'o', 'x', '', 'x'],
            ['', '', '', '', '', 'x', 'x'],
            ['', '', '', '', '', '', 'x']
          ]

          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to be true
        end
      end

      context 'when starting from bottom-left corner' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['x', '', '', '', '', '', ''],
            ['o', 'x', '', '', '', '', 'o'],
            ['o', '', 'x', 'x', '', '', 'o'],
            ['', '', 'x', 'o', '', '', 'x'],
            ['', 'x', '', '', '', 'x', 'x'],
            ['x', '', '', '', '', '', 'x']
          ]

          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          setup = board.four_in_a_row?

          # Assert
          expect(setup).to eq true
        end
      end

      context 'when starting from top-right corner' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['x', '', '', '', '', '', 'x'],
            ['o', 'x', '', '', '', 'x', 'o'],
            ['o', '', 'x', 'x', 'x', '', 'o'],
            ['', '', '', 'x', '', '', 'x'],
            ['', 'x', '', '', '', 'x', 'x'],
            ['x', '', '', '', '', '', 'x']
          ]

          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          setup = board.four_in_a_row?

          # Assert
          expect(setup).to eq true
        end
      end

      context 'when not starting from a corner' do
        it 'returns true' do
          # Arrange
          board_arrangement = [
            ['', '', '', '', '', '', ''],
            ['o', 'x', '', '', 'x', 'x', 'o'],
            ['o', '', 'x', 'x', 'x', '', 'o'],
            ['', '', '', 'x', '', '', 'x'],
            ['', 'x', 'x', '', '', 'x', 'x'],
            ['x', '', '', '', '', '', 'x']
          ]

          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          setup = board.four_in_a_row?

          # Assert
          expect(setup).to eq true
        end
      end

      context 'when incomplete diagonals formed' do
        it 'returns false' do
          # Arrange
          board_arrangement = [
            ['x', '', '', '', '', '', ''],
            ['o', 'x', '', '', '', '', 'o'],
            ['o', '', 'x', '', '', '', 'o'],
            ['', '', '', 'o', 'x', '', 'x'],
            ['', '', '', '', '', 'x', 'x'],
            ['', '', '', '', '', '', 'x']
          ]

          board.instance_variable_set(:@grid, board_arrangement)

          # Act
          status = board.four_in_a_row?

          # Assert
          expect(status).to be false
        end
      end
    end
  end

  describe '#place_disc' do
    let(:player) { double('player', disc: 'A') }

    context 'when grid is empty' do
      it 'places disc in bottom row' do
        # Arrange
        changed_board = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['A', '', '', '', '', '', '']
        ]

        # Act
        board.place_disc(player.disc, 0)

        # Assert
        expect(board.grid).to eq changed_board
      end
    end

    context 'when grid has a disc on selected column' do
      it 'places disc above it' do
        # Arrange
        starting_board = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['A', '', '', '', '', '', '']
        ]

        changed_board = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['A', '', '', '', '', '', ''],
          ['A', '', '', '', '', '', '']
        ]

        board.instance_variable_set(:@grid, starting_board)

        # Act
        board.place_disc(player.disc, 0)

        # Assert
        expect(board.grid).to eq changed_board
      end
    end

    context 'when only a single empty cell is left' do
      it 'fills up column by placing disc' do
        # Arrange
        starting_board = [
          ['', '', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', '']
        ]

        changed_board = [
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', ''],
          ['', 'A', '', '', '', '', '']
        ]

        board.instance_variable_set(:@grid, starting_board)

        # Act
        board.place_disc(player.disc, 1)

        # Assert
        expect(board.grid).to eq changed_board
      end
    end
  end

  describe '#to_s' do
    it 'returns a nicely formatted board' do
      # Arrange
      player1 = "\u{1f534}"
      player2 = "\u{1f535}"
      square = "\e[47m  \e[0m"
      board_arrangement = [
        ['', player1, '', '', '', '', ''],
        ['', player1, '', '', '', '', ''],
        ['', player1, '', '', player1, '', player1],
        ['', player2, '', '', player2, player2, player2],
        ['', player2, player1, '', player2, player1, player1],
        ['', player2, player2, player2, player2, player1, player1]
      ]
      board.instance_variable_set(:@grid, board_arrangement)

      expected_output = <<~HEREDOC

          #{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}#{square}
          #{square}|==================================|#{square}
          #{square}| \e[32m\u24b6    \u24b7    \u24b8    \u24b9    \u24ba    \u24bb    \u24bc\e[0m  |#{square}
          #{square}|==================================|#{square}
          #{square}|    | #{player1} |    |    |    |    |    |#{square}
          #{square}|----+----+----+----+----+----+----|#{square}
          #{square}|    | #{player1} |    |    |    |    |    |#{square}
          #{square}|----+----+----+----+----+----+----|#{square}
          #{square}|    | #{player1} |    |    | #{player1} |    | #{player1} |#{square}
          #{square}|----+----+----+----+----+----+----|#{square}
          #{square}|    | #{player2} |    |    | #{player2} | #{player2} | #{player2} |#{square}
          #{square}|----+----+----+----+----+----+----|#{square}
          #{square}|    | #{player2} | #{player1} |    | #{player2} | #{player1} | #{player1} |#{square}
          #{square}|----+----+----+----+----+----+----|#{square}
          #{square}|    | #{player2} | #{player2} | #{player2} | #{player2} | #{player1} | #{player1} |#{square}
          #{square}|----+----+----+----+----+----+----|#{square}
        #{square}#{square}#{square}                                #{square}#{square}#{square}

      HEREDOC

      # Act
      actual_output = board.to_s

      # Assert
      expect(actual_output).to eq expected_output
    end
  end
end

# rubocop: enable Metrics/BlockLength
