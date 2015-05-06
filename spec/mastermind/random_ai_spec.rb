require 'spec_helper'
require 'mastermind/random_ai'
require 'mastermind/scoring_feedback'

module Mastermind
  describe RandomAI do
    let(:feedback) { ScoringFeedback.new(0, 0) }

    it "returns a random guess that is 4 characters long" do
      ai = RandomAI.new
      expect(ai.next_guess(feedback).length).to eq(4)
    end

    it "returns a guess and each character is one of RGOYBP" do
      ai = RandomAI.new
      guess = ai.next_guess(feedback)

      guess.each_char do |char|
        expect(Guess::COLOURS).to include(char)
      end
    end
  end
end
