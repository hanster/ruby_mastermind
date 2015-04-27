module Mastermind
  class CodeScoreCalculator

    def exact_match_count(code, guess)
      (0..(guess.length - 1)).reduce(0) do |count, index|
        count + (exact_match?(code, guess, index) ? 1 : 0)
      end
    end

    def unexact_match_count(code, guess)
      total_matches(code, guess) - exact_match_count(code, guess)
    end

    private

    def total_matches(code, guess)
      count = 0
      code_array = code.split('')
      (0..(guess.length - 1)).each do |index|
        if (code_array.include?(guess[index]))
            count += 1
            delete_first_match(code_array, guess[index])
        end
      end
      count
    end

    def exact_match?(code, guess, index)
      code[index] == guess[index]
    end


    def delete_first_match(code, letter)
      code.delete_at(code.index(letter)) if (code.index(letter))
    end

  end
end
