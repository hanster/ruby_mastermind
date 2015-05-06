require 'spec_helper'
require 'mastermind/score_filter_ai'
require 'mastermind/code_score_calculator'

module Mastermind
  describe ScoreFilterAi do
    let(:ai) { ScoreFilterAi.new }
    let(:code_score_calc) { CodeScoreCalculator.new }
    let(:feedback) { ScoringFeedback.new(0, 0) }

    it "starts with an initial guess of 'RRGG'" do
      expect(ai.next_guess(feedback)).to eq('RRGG'.split(''))
    end

    it "second next guess is in in the set of all guesses" do
      ai.next_guess(feedback)
      expect(Guess::ALL_PERMUTATIONS).to include(ai.next_guess(feedback))
    end

    it "works out the correct answer in under 10 guesses" do
      code = 'RBPO'.split('')
      guess_correct = false
      feedback = ScoringFeedback.new(0, 0)
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

      expect(number_of_guesses).to be < 10
    end
  end
end
