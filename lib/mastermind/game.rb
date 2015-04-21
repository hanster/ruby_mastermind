module Mastermind
  class Game
    attr_reader :number_of_guesses

    def initialize (output, input = STDIN)
      @output = output
      @input = input
    end

    def start
      @output.puts("Welcome to Mastermind!")  
      @output.puts("Start game? Make sure you have a code ready!")
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
