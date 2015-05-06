require 'mastermind/guess'
require 'mastermind/scoring_feedback'

module Mastermind
  class CodeScoreCalculator
    def score(code, guess)
      ScoringFeedback.new(exact_match_count(code, guess), unexact_match_count(code, guess))
    end

    private

    def exact_match_count(code, guess)
      (0...Guess::LENGTH).reduce(0) do |count, index|
        count + (code[index] == guess[index] ? 1 : 0)
      end
    end

    def unexact_match_count(code, guess)
      total_matches(code, guess) - exact_match_count(code, guess)
    end

    # Long method. More ruby way of doing this?
    def total_matches(code, guess)
      code_array = code.dup
      count = 0
      (0...Guess::LENGTH).each do |index|
        match_index = code_array.index(guess[index])
        if (match_index)
          code_array.delete_at(match_index)
          count += 1
        end
      end
      count
    end
  end
end
