module Mastermind
  class CodeScoreCalculator
    def exact_match_count(code, guess)
      (0..3).reduce(0) do |count, index|
        count + (code[index] == guess[index] ? 1 : 0)
      end
    end

    def unexact_match_count(code, guess)
      total_matches(code, guess) - exact_match_count(code, guess)
    end

    def score(code, guess)
      score = []
      exact_count = exact_match_count(code, guess)
      score.push(exact_count)
      score.push(total_matches(code, guess) - exact_count)
    end

    private

    def total_matches(code, guess)
      code_array = code.dup
      count = 0
      (0..3).each do |index|
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
