require_relative 'player'
require_relative 'cage'
require_relative 'string'

class Game
  def initialize
    @cage = Cage.new
    @player1 = Player.new 'Player 1', 1
    @player2 = Player.new 'Player 2', 2
    @current_player = @player2
  end

  def introduction 
    puts "Welcome to connecting four."
    puts "This is a game where two players will take turns choosing a column to drop their pieces."
    puts "The first one to make a 4 row wins!"
    @cage.print_cage
    puts "Player 1 will have the piece " + "\u26aB".red
    puts "Player 2 will have the piece "+ "\u26aB".blue
  end

  def change_turn 
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def play
    until game_over?
      change_turn
      @cage.print_cage
      puts "#{@current_player.name} " + (@current_player == @player1 ? "\u26aB".red : "\u26aB".blue)
      player_move = @current_player.drop_piece(@cage.columns)
      @cage.insert_piece(player_move[:piece], player_move[:column])
    end
    game_result
  end

  def game_over?
    @cage.check_game_over == 'win' || @cage.check_game_over == 'draw'
  end

  def game_result
    @cage.print_cage
    if @cage.check_game_over == 'win'
      print "#{@current_player.name} "
      if @current_player == @player1
        print "\u26aB".red
      else
        print "\u26aB".blue
      end
      puts "wins!"
    else
      puts "It's a draw!"
    end
  end

  def play_again?
    puts " Do you want to play again? Input y for yes and n for no"
    input = gets.chomp
    until input == 'y' || input == 'n'
      puts "Please input y for yes or n for no".red
      input = gets.chomp
    end
    return true if input == 'y'
    return false if input == 'n'
  end
end