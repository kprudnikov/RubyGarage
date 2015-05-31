require_relative "../lib/CodeBreaker"

game = CodeBreaker::Interface.new
game.greeting_message {|message| puts message}

while (input = gets.chomp) do
  game.process_input(input) do |response|
    if response
      puts response
      if response == "++++"
        game.success_message{ |message| puts message}
        game.save_result("won") {|message| puts message }
        game.prompt_restart(){|message| puts message }
      end
    else
      game.fail_message { |message| puts message}
      game.save_result("lost") { |message| puts message}
      game.prompt_restart(){ |message| puts message}      
    end
  end
end