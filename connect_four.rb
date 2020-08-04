# frozen_string_literal: true

require_relative './lib/game.rb'
loop do
  game = Game.new
  game.create_players
  game.play_turns
  puts game.game_over_message
end
