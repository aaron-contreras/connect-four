# frozen_string_literal: true

require_relative '../lib/game.rb'
describe Game do
  let(:game) { described_class.new }

  describe '#start_game' do
    it 'creates two players' do
      # Arrange
      allow(game).to receive(:print).twice
      allow(game).to receive(:gets).and_return('Aaron', 'Chad')

      # Act
      game.start_game

      players = game.instance_variable_get(:@players)

      # Assert
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
