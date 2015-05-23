require_relative "lib/CodeBreaker"

def print_help
  puts "Ok, here's the deal: you enter 4 digits, 1 to 6.\nYou'll get number of '+' and '-' after each attempt. \n'+' indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position.\n'-' indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position.\nYou have 6 shots."
end

def restart_game(game)
  answer = gets.chomp
  if answer == "y" || answer == "yes"
    # attempts_number = 0
    game.start
  else
    abort("See ya!")
  end
end

def user_won(game)
  puts "You won! Wanna play again? y/n"
  restart_game game
end

def user_lost (game)
  puts "You lost. C’est la vie. Wanna play again?"
  restart_game game
end

puts "Howdy stranger! I want to play a game with you. You know the rules."
game = CodeBreaker::Game.new
game.start
# attempts_number = 0

while (input = gets.chomp) do
  if(input == "help")
    print_help
  elsif (input == "hint")
    hint = game.hint
    if hint
      puts hint
    else
      puts "Sorry, buddy, you've already used your hint"
    end
  elsif (input == "exit")
    puts "See ya!"
    break
  else
    begin
      result = game.check(input)
      if result
        puts result
        if result == "++++"
          user_won game
        end
      else
        user_lost game
      end
    rescue
      puts "I thought rules were clear! 4 digits, 1 to 6"
    end
  end
end