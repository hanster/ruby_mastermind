module Mastermind
  class Game
    attr_reader :number_of_guesses

    def initialize (display)
      @display = display
      @exact_matches = 0
      @unexact_matches = 0
    end

    def start
      @display.display_welcome
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
      @exact_matches = @display.get_exact_matches
    end

    def get_unexact_matches
      @unexact_matches = @display.get_unexact_matches
    end

  end
  
end
