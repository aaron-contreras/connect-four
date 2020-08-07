# frozen_string_literal: true

require_relative '../lib/game.rb'

# rubocop: disable Metrics/BlockLength
describe Game do
  let(:game) { described_class.new }

  describe '#create_players' do
    it 'asks for a name until valid' do
      # Arrange
      allow(game).to receive(:print)
      allow(game).to receive(:gets).and_return('---(-=     ', 'Aaron contreras', '(pizzaboy34)', 'A1', '', 'Aaron', 'Chad')

      # Assert
      expect(game).to receive(:gets).exactly(6).times

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

  describe '#play_turns' do
    let(:player_one) { double('player 1', name: 'Aaron', disc: 'A') }
    let(:player_two) { double('player 2', name: 'Chad', disc: 'C') }

    context 'when game ends in a win' do
      it "loop until there's a winner" do
        # Arrange
        allow(game).to receive(:puts)
        allow(game).to receive(:print)
        allow(game).to receive(:obtain_move).and_return(0, 1, 0, 1, 0, 1, 0)

        game.instance_variable_set(:@players, [player_one, player_two])
        game.instance_variable_set(:@active_player, player_one)

        # Assert
        expect(game).to receive(:obtain_move).exactly(7).times

        # Act
        game.play_turns
      end
    end

    it "switches player's turns after every move" do
      # Arrange
      allow(game).to receive(:print)
      allow(game).to receive(:puts)
      allow(game).to receive(:obtain_move).and_return(0, 1, 0, 1, 0, 1, 0)

      game.instance_variable_set(:@players, [player_one, player_two])
      game.instance_variable_set(:@active_player, player_one)

      # Act
      game.play_turns

      # Assert
      active_player = game.instance_variable_get(:@active_player)

      expect(active_player).to eq player_one
    end
  end

  describe '#game_over_message' do
    context 'when the game is a draw' do
      it 'shows the draw message' do
        # Arrange
        double('board', four_in_a_row?: false)

        draw_message = "\e[33mIt's a draw!\e[0m"

        # Act
        actual_message = game.game_over_message

        # Assert
        expect(actual_message).to eq draw_message
      end
    end

    context 'when a player won' do
      it 'gives him a congrats message' do
        # Arrange
        board = double('board', four_in_a_row?: true)
        game.instance_variable_set(:@board, board)

        player = double('player1', name: 'Aaron')
        game.instance_variable_set(:@active_player, player)

        win_message = "\e[32mAaron won, great job!\e[0m"

        # Act
        actual_message = game.game_over_message

        # Assert
        expect(actual_message).to eq win_message
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
