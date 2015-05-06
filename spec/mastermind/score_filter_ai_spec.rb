require 'spec_helper'
require 'mastermind/score_filter_ai'
require 'mastermind/code_score_calculator'

module Mastermind
  describe ScoreFilterAi do
    let(:ai) { ScoreFilterAi.new }
    let(:code_score_calc) { CodeScoreCalculator.new }
    let(:feedback) { ScoringFeedback.new(0, 0) }

    def generate_random_code
      Guess::ALL_PERMUTATIONS.to_a.sample
    end

    it "next guess is in in the set of all guesses" do
      expect(Guess::ALL_PERMUTATIONS).to include(ai.next_guess(feedback))
    end

    it "works out the correct answer in under 10 guesses" do
      code = generate_random_code
      guess_correct = false
      feedback = ScoringFeedback.new(-1, -1)
      guess = ai.next_guess(feedback)
      number_of_guesses = 1

      until guess_correct
        if (guess == code)
          guess_correct = true
        else
          feedback = code_score_calc.score(code, guess)
          guess = ai.next_guess(feedback)
          number_of_guesses += 1
        end
      end
      puts number_of_guesses
      expect(number_of_guesses).to be < 10
    end
  end
end
