module CodeBreaker
  class Interface

    attr_reader :game_is_finished

    def initialize
      @game = Game.new
      @game.start
      @game_is_finished = false
      @username = ''
    end

    def restart_game (&block)
      @game.start
      yield "Let's play again! Rules are the same!"
    end

    def prompt_restart &block
      yield "Want to play again? y/n"
      answer = gets.chomp
      if(answer == "y")
        restart_game &block
        return
      end
      exit &block
    end

    def save_result(won_or_lost, &block)
      yield "Want to save your result? y/n"
      answer = gets.chomp
      if (answer.downcase == "y")
        if @username == ''
          get_name &block
        end
        begin
          path = File.expand_path("../../../data/result.txt", __FILE__)
          File.open(path, 'a') do |f|
            f.write("#{@username} #{won_or_lost} the game.\n")
          end
          yield "Your result is safe now, don't worry.\n\n"
        rescue
          yield "Something went wrong, we couldn't save your result."
        end
      end
    end

    def get_name (&block)
      while @username == ""
        name_message &block
        @username = gets.chomp
      end
    end

    def help_message &block
      yield "Ok, here's the deal: you enter 4 digits, 1 to 6.\nYou'll get number of '+' and '-' after each attempt. \n'+' indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position.\n'-' indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position.\nYou have 6 shots.\nYou can ask for 'hint' any moment, but only once during the game."
    end

    def process_input(input, &block)
      input = input.downcase
      if(input == "help")
        help_message(&block)
      elsif input == "hint"
        get_hint(&block)
      elsif input == "exit"
        exit(&block)
      else
        begin
          result = @game.check(input)
          if result
            yield result
          else
            yield "Game over"
            # yield false
            # ! "iteratable or stringable required" !
          end
        rescue Exception => e
          puts e
          yield "I thought rules were clear! 4 digits, 1 to 6"
        end
      end
    end

    def get_hint &block
      hint = @game.hint
      hint = "Sorry, buddy, you've already used your hint" if !hint
      yield hint
    end

    def success_message &block
      yield "You won!"
    end

    def fail_message &block
      yield "You lost. C’est la vie."
    end

    def greeting_message
      yield "Howdy stranger! I want to play a game with you. You know the rules.\nAsk for 'help' if you don't."
    end

    def restart_message
      yield "Want to restart the game?"
    end

    def name_message
      yield "What's your name, cowboy?"
    end

    def exit(&block)
      yield "See ya!"
      abort
    end
  end
end