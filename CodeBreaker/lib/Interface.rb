require_relative "CodeBreaker"

module CodeBreaker
  class Interface

    attr_reader :game_is_finished

    def initialize
      @game = Game.new
      @game.start
      @game_is_finished = false
    end

    def restart_game

    end

    def save_result

    end

    def get_help
      "Ok, here's the deal: you enter 4 digits, 1 to 6.\nYou'll get number of '+' and '-' after each attempt. \n'+' indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position.\n'-' indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position.\nYou have 6 shots.\nYou can ask for 'hint' any moment, but only once during the game."
    end

    def process_input(input, &block)
      input = input.downcase
      if(input == "help")
        get_help
      elsif input == "hint"
        get_hint
      elsif input == "exit"
        exit(&block)
      else
        begin
          result = @game.check(input)
        rescue
          "I thought rules were clear! 4 digits, 1 to 6"
        end
      end
    end

    def get_hint
      hint = @game.hint
      if hint
        hint
      else
        "Sorry, buddy, you've already used your hint"
      end
    end

    def success_message
      "You won!"
    end

    def fail_message
      "You lost. C’est la vie."
    end

    def greeting_message
      "Howdy stranger! I want to play a game with you. You know the rules.\nAsk for 'help' if you don't."
    end

    def exit(&block)
      yield "Exit message"
      abort
    end
  end
end