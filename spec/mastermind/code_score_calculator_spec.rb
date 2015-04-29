require 'spec_helper'
require 'mastermind/code_score_calculator'

module Mastermind

  describe CodeScoreCalculator do
    
    let(:code_score_calculator) { CodeScoreCalculator.new }

    describe "#exact_match_count" do
      it "returns 0 when there are no matches" do
        expect(code_score_calculator.exact_match_count('RRRR'.split(''), 'GGGG'.split(''))).to eq(0)
      end

      it "returns 1 when there is one match do" do
        expect(code_score_calculator.exact_match_count('RGBO'.split(''), 'RPPP'.split(''))).to eq(1)
      end
      
      it "returns 4 when all match" do 
        expect(code_score_calculator.exact_match_count('RGBO'.split(''), 'RGBO'.split(''))).to eq(4)
      end
    end

    describe "#unexact_match_count" do
      it "returns 0 when there are no matches" do
        expect(code_score_calculator.exact_match_count('RRRR'.split(''), 'GGGG'.split(''))).to eq(0)
      end

      it "returns 1 when there is one match" do
        expect(code_score_calculator.unexact_match_count('RGBO'.split(''), 'OPPP'.split(''))).to eq(1)
      end
      
      it "returns 0 when there is one exact match and a duplicate in guess" do
        expect(code_score_calculator.unexact_match_count('RBYO'.split(''), 'RRPP'.split(''))).to eq(0)
      end

      it "returns 1 when there is 1 exact and 1 unexact match" do
        expect(code_score_calculator.unexact_match_count('RBGO'.split(''), 'RYBP'.split(''))).to eq(1)
      end

      it "returns 1 when there is only 1 match but duplicates in the guess" do
        expect(code_score_calculator.unexact_match_count('RBYO'.split(''), 'PRRR'.split(''))).to eq(1)
      end

      it "returns 2" do
        expect(code_score_calculator.unexact_match_count('RBYO'.split(''), 'PRBG'.split(''))).to eq(2)
      end

    end

    describe "#score" do
      it "returns [0, 0] when no matches" do
        expect(code_score_calculator.score('RRRR'.split(''), 'YYYY')).to eq([0, 0])
      end

      it "returns [4, 0] when all are exact matches" do
        expect(code_score_calculator.score('RRRR'.split(''), 'RRRR')).to eq([4, 0])
      end

      it "returns [0, 4] when all are unexact matches" do
        expect(code_score_calculator.score('RYOP'.split(''), 'POYR')).to eq([0, 4])
      end

      it "returns [1, 3] when 1 exact and 3 unexact matches" do
        expect(code_score_calculator.score('RYOP'.split(''), 'YORP'.split(''))).to eq([1, 3])
      end

    end
  end
end
