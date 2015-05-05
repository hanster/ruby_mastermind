require 'spec_helper'
require 'mastermind/code_score_calculator'

module Mastermind
  describe CodeScoreCalculator do
    let(:code_score_calculator) { CodeScoreCalculator.new }

    def feedback(exact, unexact)
      ScoringFeedback.new(exact, unexact)
    end

    describe "#score" do
      it "returns feedback of [1, 0] when there is only 1 exact match" do 
        expect(code_score_calculator.score('RBYO'.split(''), 'RPPP'.split(''))).to eq(feedback(1, 0))
      end
      it "returns feedback of [0, 1] when there is only 1 unexact match but duplicates in the guess" do
        expect(code_score_calculator.score('RBYO'.split(''), 'PRRR'.split(''))).to eq(feedback(0, 1))
      end
      it "returns feedback of [0, 0] when no matches" do
        expect(code_score_calculator.score('RRRR'.split(''), 'YYYY')).to eq(feedback(0, 0))
      end
      it "returns feedback of [4, 0] when all are exact matches" do
        expect(code_score_calculator.score('RRRR'.split(''), 'RRRR')).to eq(feedback(4, 0))
      end

      it "returns feedback of [0, 4] when all are unexact matches" do
        expect(code_score_calculator.score('RYOP'.split(''), 'POYR')).to eq(feedback(0, 4))
      end

      it "returns feedback of [1, 3] when 1 exact and 3 unexact matches" do
        expect(code_score_calculator.score('RYOP'.split(''), 'YORP'.split(''))).to eq(feedback(1, 3))
      end
    end
  end
end
