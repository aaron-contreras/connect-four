# frozen_string_literal: true

require 'colorize'
require_relative './board.rb'
require_relative './output.rb'
# A Connect-4 Game
class Game
  include Output

  attr_reader :board

  def initialize
    @board = Board.new
  end

  Player = Struct.new(:name, :disc)

  def create_players
    ask_for_player_name(1)
    player_one = Player.new(obtain_name, RED_DISC)
    ask_for_player_name(2)
    player_two = Player.new(obtain_name, BLUE_DISC)

    @players = [player_one, player_two]
    @active_player = @players.sample
  end

  def switch_turns
    @active_player = @active_player == @players[0] ? @players[1] : @players[0]
  end

  def game_over_message
    if board.four_in_a_row?
      "#{@active_player.name} won, great job!"
    else
      "It's a draw!"
    end
  end

  def play_turns
    loop do
      ask_for_player_move

      board.place_disc(@active_player.disc, obtain_move)

      clear_screen

      puts board

      break if board.four_in_a_row? || board.tie?

      switch_turns
    end
  end

  private

  def ask_for_player_name(player_number)
    color = player_number == 1 ? :red : :blue

    player = "player #{player_number}".send(color)

    print "What is #{player}'s name? "
  end

  def obtain_name
    loop do
      name = gets.chomp.strip

      break name if name.match?(/^[\w]+$/)

      print 'Please enter a valid name (Alphanumeric only, no spaces): '.red
    end
  end

  def ask_for_player_move
    print "#{@active_player.disc} #{@active_player.name}, where would you like to drop your disc? "
  end

  def valid_move?(move)
    return false unless move.length == 1

    column_index = move.ord - 65

    move.between?('A', 'G') && @board.column_not_full?(column_index)
  end

  def obtain_move
    loop do
      move = gets.upcase.strip

      break move.ord - 65 if valid_move?(move)

      clear_line_above

      print 'Enter a valid column to drop your disc on (A-G): '.red
    end
  end
end
