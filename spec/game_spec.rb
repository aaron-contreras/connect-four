# frozen_string_literal: true

require_relative '../lib/game.rb'

# rubocop: disable Metrics/BlockLength
describe Game do
  let(:game) { described_class.new }

  describe '#create_players' do
    it 'asks for a name until valid' do
      # Arrange
      allow(game).to receive(:print)
      allow(game).to receive(:gets).and_return('A1', '  ', 'Aaron', 'Chad')

      # Assert
      expect(game).to receive(:gets).exactly(4).times

      # Act
      game.create_players
    end

    it 'creates 2 players' do
      # Arrange
      allow(game).to receive(:print)
      allow(game).to receive(:gets).and_return('Aaron', 'Chad')

      # Act
      game.create_players

      # Assert
      players = game.instance_variable_get(:@players)
      expect(players.length).to eq 2
    end

    it 'gives a player the starting turn' do
      # Arrange
      allow(game).to receive(:print)
      allow(game).to receive(:gets).and_return('Aaron', 'Chad')

      # Act
      game.create_players

      # Assert
      active_player = game.instance_variable_get(:@active_player)
      expect(active_player).not_to be_nil
    end
  end

  describe '#switch_turns' do
    let(:player_one) { double('player 1') }
    let(:player_two) { double('player 2') }

    context 'when player 1 is the active player' do
      it 'makes player 2 the active player' do
        # Arrange
        game.instance_variable_set(:@players, [player_one, player_two])
        game.instance_variable_set(:@active_player, player_one)

        # Act
        game.switch_turns

        # Assert
        active_player = game.instance_variable_get(:@active_player)

        expect(active_player).to eq player_two
      end
    end
    
    context 'when player 2 is the active player' do
      it 'makes player 1 the active player' do
        # Arrange
        game.instance_variable_set(:@players, [player_one, player_two])
        game.instance_variable_set(:@active_player, player_two)

        # Act
        game.switch_turns

        # Assert
        active_player = game.instance_variable_get(:@active_player)
        expect(active_player).to eq player_one
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
