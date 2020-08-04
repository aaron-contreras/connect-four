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

  def game_over_message
    if @board.four_in_a_row?
      "#{@active_player.name} won, great job!"
    else
      "It's a draw!"
    end
  end

  def play_turns
    puts @board

    loop do
      ask_for_player_move

      move = obtain_move

      @board.place_disc(@active_player.disc, move)

      puts @board

      break if @board.four_in_a_row?

      switch_turns
    end
  end

  private

  def ask_for_player_name(player_number)
    print "What is #{player_number}'s name? "
  end

  def obtain_name
    name = gets.chomp.strip

    while name.empty? || name.match?(/\d+/)
      print 'Please enter a valid name: '
      name = gets.chomp.strip
    end

    name
  end

  def ask_for_player_move
    print "#{@active_player.name} Where would you like to drop your disc? "
  end

  def obtain_move
    move = gets.chomp.strip

    until move.match?(/[a-gA-G]/)
      print 'Please enter a valid column: '
      move = gets.chomp.strip
    end

    move
  end
end
