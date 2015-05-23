require_relative "CodeBreaker/version"

module CodeBreaker

  class Game

    attr_reader :code

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
      temp_code = @code.dup
      raise(ArgumentError, "argument should be a string 4 symbols long") if input.length != @code_length
      raise(ArgumentError, "argument should contain only numbers 1 to #{@max_code_value}") if !input.match(/[1-6}]{4}/)
      # raise(ArgumentError, "argument should contain only numbers 1 to #{@max_code_value}") if !input.match(Regex.new("[1-#{@max_code_value}]{#{@code_length}}"))

      result = ""
      # input.each_char.with_index do |c, i|
      #   if(c == temp_code[i])
      #     result << "+"
      #     input[i] = "_"
      #     temp_code[i] = "_"
      #   end
      # end

(0...4).each do |index|
  if(temp_code[index] == input[index])
    result << "+"
    input[index] = "_"
    temp_code[index] = "_"
  end
end

      # for some reason it doesn't update variable while in each_char loop
      # let's try with for loop

      # temp_code.each_char.with_index do |char_code, index_code|
      #     input.each_char.with_index do |char_input, index_input|
      #       if char_code == char_input && char_code != "_"
      #         temp_code[index_code] = "_"
      #         input[index_input] = "_"
      #         result << "-"
      #       end
      #     end
      # end

(0...4).each do |index_out|
  (0...4).each do |index_in|
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

# game = CodeBreaker::Game.new
# # game.start
# game.send(:set_code, "1234")
# puts game.check("3346") 
# # --
# puts game.check("1111")
# # +
# puts game.check("5631").inspect
# puts game.code
# # +-