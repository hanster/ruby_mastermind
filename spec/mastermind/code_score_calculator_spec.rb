require 'spec_helper'
require 'mastermind/code_score_calculator'

module Mastermind

  describe CodeScoreCalculator do
    
    let(:code_score_calculator) { CodeScoreCalculator.new }

    describe "#exact_match_count" do
      it "returns 0 when there are no matches" do
        expect(code_score_calculator.exact_match_count('RRRR', 'GGGG')).to eq(0)
      end

      it "returns 1 when there is one match do" do
        expect(code_score_calculator.exact_match_count('RGBO', 'RPPP')).to eq(1)
      end
      
      it "returns 4 when all match" do 
        expect(code_score_calculator.exact_match_count('RGBO', 'RGBO')).to eq(4)
      end
    end

    describe "#unexact_match_count" do
      it "returns 0 when there are no matches" do
        expect(code_score_calculator.exact_match_count('RRRR', 'GGGG')).to eq(0)
      end

      it "returns 1 when there is one match" do
        expect(code_score_calculator.unexact_match_count('RGBO', 'OPPP')).to eq(1)
      end
      
      it "returns 0 when there is one exact match and a duplicate in guess" do
        expect(code_score_calculator.unexact_match_count('RBYO', 'RRPP')).to eq(0)
      end

      it "returns 1 when there is 1 exact and 1 unexact match" do
        expect(code_score_calculator.unexact_match_count('RBGO', 'RYBP')).to eq(1)
      end

      it "returns 1 when there is only 1 match but duplicates in the guess" do
        expect(code_score_calculator.unexact_match_count('RBYO', 'PRRR')).to eq(1)
      end

      it "returns 2" do
        expect(code_score_calculator.unexact_match_count('RBYO', 'PRBG')).to eq(2)
      end

    end
  end
end
