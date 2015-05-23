require "CodeBreaker/version"

module CodeBreaker

  class Game

    def initialize(max_code_value=6, code_length=4)
      @max_code_value = max_code_value
      @code_length = code_length
      @code = ""
      @hint_is_given = false
    end

    def start 
      @code_length.times do
        @code << rand(1..@max_code_value).to_s
      end
      @code
    end

    def check(input)
      input = input.chomp
      raise(ArgumentError, "should be a string 4 symbols long") if input.length != 4

      "1234"
    end

    def hint
      if (!@hint_is_given)
        index = rand(0...4)
        @hint_is_given = true
        return @code[index]
      else
        return false
      end
    end

private

  def set_code(code)
    @code = code
  end

  end
end
