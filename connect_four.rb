# frozen_string_literal: true

require_relative './lib/game.rb'

title = '|   CONNECT FOUR   |'
border = "+#{'=' * (title.length - 2)}+"
intro = <<~INTRO

  \e[32m#{border.center(40)}
  #{title.center(40)}
  #{border.center(40)}\e[0m


INTRO

loop do
  print "\e[2J"
  print "\e[H"

  game = Game.new
  puts intro
  game.create_players

  print "\e[2J"
  print "\e[H"

  game.play_turns

  puts game.game_over_message
  print 'Would you like to play again? (y/n) -> '
  play_again = gets.chomp.strip.downcase

  until %w[y n].include? play_again
    print "\e[31mYour options are 'y' or 'n'\e[0m -> "
    play_again = gets.chomp.strip.downcase
  end

  break if play_again == 'n'
end
