module Mastermind
  class Game
    attr_reader :number_of_guesses

    def initialize (output, input = STDIN)
      @input = input
      @io = IO.new(output)
    end

    def start
      @io.display_welcome
      @number_of_guesses = 0
    end

    def guess
      @number_of_guesses += 1
      return "RRRR"
    end

    def over?
      @number_of_guesses >= 10 || @exact_matches == 4
    end

    def get_exact_matches
      @exact_matches = @input.get_user_input
    end

    def get_unexact_matches
      @unexact_matches = @input.get_user_input
    end

  end
  
end
