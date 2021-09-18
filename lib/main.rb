require_relative 'game'

def main
  play_game = true
  until play_game == false
    game = Game.new
    game.introduction
    game.play
    play_game = game.play_again?
  end
  puts "Thank you for playing connecting four. Have a nice day."
end

main