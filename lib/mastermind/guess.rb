module Mastermind
  class Guess
    COLOURS = ['R', 'G', 'O', 'Y', 'B', 'P']
    POSSIBLE_FEEDBACK = [
        [0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
        [1, 3], [1, 2], [1, 1], [1, 0],
        [2, 0], [2, 1], [2, 2],
        [3, 0],
        [4, 0]
      ]

    ALL_PERMUTATIONS = COLOURS.repeated_permutation(4)
  end
end
