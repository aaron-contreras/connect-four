# frozen_string_literal: true

require_relative './board.rb'
require_relative './player.rb'
# A Connect-4 Game
class Game
  def initialize
    @board = Board.new
  end

  def create_players
    ask_for_player_name(1)
    player_one = Player.new(obtain_name, "\u{1f534}")
    ask_for_player_name(2)
    player_two = Player.new(obtain_name, "\u{1f535}")

    @players = [player_one, player_two]
    @active_player = @players.sample
  end

  def switch_turns
    @active_player = @active_player == @players[0] ? @players[1] : @players[0]
  end

  def game_over_message
    if @board.four_in_a_row?
      "\e[32m#{@active_player.name} won, great job!\e[0m"
    else
      "\e[33mIt's a draw!\e[0m"
    end
  end

  def play_turns
    puts @board

    loop do
      ask_for_player_move

      move = obtain_move

      @board.place_disc(@active_player.disc, move)

      print "\e[2J\e[H"

      puts @board

      break if @board.four_in_a_row?

      switch_turns
    end
  end

  private

  def ask_for_player_name(player_number)
    color = player_number == 1 ? "\e[31m" : "\e[34m"
    print "What is #{color}player #{player_number}'s\e[0m name? "
  end

  def obtain_name
    name = gets.chomp.strip

    while name.empty? || name.match?(/[^A-Za-z\s]/)
      print "\e[31mPlease enter a valid name: \e[0m"
      name = gets.chomp.strip
    end

    name
  end

  def ask_for_player_move
    print "#{@active_player.disc} #{@active_player.name}, where would you like to drop your disc? "
  end

  def obtain_move
    loop do
      move = gets.upcase.strip

      break move.ord - 65 if !move.empty? &&
                             move.between?('A', 'G') &&
                             @board.column_not_full?(move.ord - 65)

      print "\e[1A\e[K\e[31mEnter a valid column to drop your disc on: \e[0m"
    end
  end
end
