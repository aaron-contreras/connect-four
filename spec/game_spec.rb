# frozen_string_literal: true

require_relative '../lib/game.rb'
describe Game do
  let(:game) { described_class.new }

  describe '#start_game' do
    context 'when given an invalid name' do
      it 'asks for a name until valid' do
        # Arrange
        allow(game).to receive(:print)
        allow(game).to receive(:gets).and_return('Aaron1', '', 'Aaron', 'Chad')
        allow(game).to receive(:play_turns)

        # Assert
        expect(game).to receive(:gets).exactly(4).times

        # Act
        game.start_game
      end
    end

    it 'creates two players' do
      # Arrange
      allow(game).to receive(:print).twice
      allow(game).to receive(:gets).and_return('Aaron', 'Chad')
      allow(game).to receive(:play_turns)

      # Act
      game.start_game


      # Assert
      players = game.instance_variable_get(:@players)
      expect(players.size).to eq 2
    end

    it 'plays turns' do
      # Arrange
      allow(game).to receive(:print).twice
      allow(game).to receive(:gets).and_return('Aaron', 'Chad')

      # Assert
      expect(game).to receive(:play_turns)

      # Act
      game.start_game
    end
  end
end
