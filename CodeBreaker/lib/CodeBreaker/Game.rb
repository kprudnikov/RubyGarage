require_relative "version"

module CodeBreaker

  class Game

    attr_reader :attempts_number

    def initialize(max_code_value=6, code_length=4, max_attempts_number=6)
      @max_code_value = max_code_value
      @code_length = code_length
      @max_attempts_number = max_attempts_number
      @code = ""
    end

    def start 
      @code_length.times do
        @code << rand(1..@max_code_value).to_s
      end
      @hint_is_given = false
      @attempts_number = 0
      @code
    end

    def check(input)
      input = input.chomp
      temp_code = @code.dup
      raise(ArgumentError, "argument should be a string 4 symbols long") if input.length != @code_length
      raise(ArgumentError, "argument should contain only numbers 1 to #{@max_code_value}") if !input.match(/[1-6}]{4}/)
      # cannot find Regex - looking for CodeBreaker::Game::Regex
      # raise(ArgumentError, "argument should contain only numbers 1 to #{@max_code_value}") if !input.match(Regex.new("[1-#{@max_code_value}]{#{@code_length}}"))

      @attempts_number += 1
      if @attempts_number > @max_attempts_number
        return false
      end

      result = ""

      (0...@code_length).each do |index|
        if(temp_code[index] == input[index])
          result << "+"
          input[index] = "_"
          temp_code[index] = "_"
        end
      end

      # for some reason it doesn't update variable while in each_char loop
      # let's try with simple iteration

      (0...@code_length).each do |index_out|
        (0...@code_length).each do |index_in|
          if temp_code[index_out] == input[index_in] && input[index_in] != "_"
            temp_code[index_out] = "_"
            input[index_in] = "_"
            result << "-"
          end
        end
      end

      result
    end

    def hint
      if (!@hint_is_given)
        index = rand(0...@code_length)
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