module Mastermind

  class Guess
    COLOURS = ['R', 'G', 'O', 'Y', 'B', 'P']

    ALL_PERMUTATIONS = COLOURS.repeated_permutation(4)

    def self.get_all_permutations
      ALL_PERMUTATIONS.map { |guess| guess.join('') }
    end

  end
  
end
