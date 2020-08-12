# frozen_string_literal: true

require_relative './lib/game.rb'
require 'colorize'

title = '|   CONNECT FOUR   |'
border = "+#{'=' * (title.length - 2)}+"
intro = <<~INTRO.green.bold

  #{border.center(40)}
  #{title.center(40)}
  #{border.center(40)}


INTRO

loop do
  print "\e[2J"
  print "\e[H"

  game = Game.new
  puts intro
  game.create_players

  print "\e[2J"
  print "\e[H"
  puts game.board

  game.play_turns

  puts game.game_over_message.green.bold
  print 'Would you like to play again? (y/n) -> '
  play_again = gets.chomp.strip.downcase

  until %w[y n].include? play_again
    print "#{"Your options are 'y' or 'n'".red.bold} -> "
    play_again = gets.chomp.strip.downcase
  end

  break if play_again == 'n'
end
