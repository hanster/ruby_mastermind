require 'mastermind/guess'

module Mastermind

  class RandomAI

    def next_guess(exact_matches, unexact_matches)
      guess = ''
      4.times do
        guess += Guess::COLOURS.sample
      end
      guess
    end

  end

end
