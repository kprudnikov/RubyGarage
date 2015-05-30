require_relative "../lib/CodeBreaker"

game = CodeBreaker::Interface.new
game.greeting_message {|message| puts message}

while (input = gets.chomp) do
  game.process_input(input) do |response|
    puts response
  end
end