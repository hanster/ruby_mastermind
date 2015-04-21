module Mastermind
  class Game
    attr_reader :number_of_guesses

    def initialize (io)
      @io = io
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
      @exact_matches = @io.get_exact_matches
    end

    def get_unexact_matches
      @unexact_matches = @io.get_unexact_matches
    end

  end
  
end
