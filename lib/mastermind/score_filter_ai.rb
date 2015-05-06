require 'mastermind/guess'
require 'mastermind/code_score_calculator'

module Mastermind
  class ScoreFilterAi
    def initialize
      @initial_guess = true
      @set_of_guesses = Guess::ALL_PERMUTATIONS
      @current_guess = "RRGG".split('')
      @code_score_calc = Mastermind::CodeScoreCalculator.new
    end

    def next_guess(feedback)
      if initial_guess
        @initial_guess = false
        return current_guess
      end
      update_set_of_guesses(feedback)
      @current_guess = set_of_guesses[0]
    end

    private

    attr_reader :initial_guess, :set_of_guesses, :current_guess, :code_score_calc 

    def update_set_of_guesses(feedback)
      @set_of_guesses = @set_of_guesses.select do |a_guess|
        feedback == code_score_calc.score(current_guess, a_guess)
      end
    end
  end
end
