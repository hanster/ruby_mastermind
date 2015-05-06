module Mastermind
  module Guess
    COLOURS = ['R', 'G', 'O', 'Y', 'B', 'P']
    LENGTH = 4
    ALL_PERMUTATIONS = COLOURS.repeated_permutation(LENGTH)
  end
end
