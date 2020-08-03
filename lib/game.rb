# frozen_string_literal: true

# A Connect-4 Game
class Game
  def initialize
    @board = Board.new
  end

  def create_players
    ask_for_player_name(1)
    player_one = Player.new(obtain_name, 'A')
    ask_for_player_name(2)
    player_two = Player.new(obtain_name, 'B')

    @players = [player_one, player_two]
    @active_player = @players.sample
  end

  def switch_turns
    @active_player = @active_player == @players[0] ? @players[1] : @players[0]
  end

  private

  def ask_for_player_name(player_number) 
    print "What is #{player_number}'s name?"
  end

  def obtain_name
    name = gets.chomp

    while name.empty? || name.strip.empty? || name.match?(/\d+/)
      print 'Please enter a valid name'
      name = gets.chomp
    end      

    name
  end
end
