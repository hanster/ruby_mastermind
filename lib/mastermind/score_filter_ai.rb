require 'mastermind/guess'
require 'mastermind/code_score_calculator'

module Mastermind
  class ScoreFilterAi
    def initialize(set_of_guesses = Guess::ALL_PERMUTATIONS)
      @set_of_guesses = set_of_guesses
      @current_guess = @set_of_guesses.to_a.sample
      @code_score_calc = Mastermind::CodeScoreCalculator.new
    end

    def next_guess(feedback)
      return current_guess if initial_guess?(feedback)
      @set_of_guesses = filter_set_of_guesses(@set_of_guesses, feedback)
      @current_guess = set_of_guesses[0]
    end

    private

    attr_reader :initial_guess, :set_of_guesses, :current_guess, :code_score_calc 

    def initial_guess?(feedback)
      feedback == ScoringFeedback.new(-1, -1)
    end

    def filter_set_of_guesses(set_of_guesses, feedback)
      set_of_guesses.select do |a_guess|
        feedback == code_score_calc.score(current_guess, a_guess)
      end
    end
  end
end
