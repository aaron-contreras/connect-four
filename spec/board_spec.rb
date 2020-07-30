require_relative '../lib/board.rb'
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
    context 'when four in a row horizontally in first row' do
      it 'returns true' do
        # Arrange
        board_arrangement = [
          ['x', 'x', 'x', 'x', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
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

    context 'when four in a row horizontally in second row' do
      it 'returns true' do
        # Arrange
        board_arrangement = [
          ['', '', '', '', '', '', ''],
          ['x', 'x', 'x', 'x', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
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
  end
end