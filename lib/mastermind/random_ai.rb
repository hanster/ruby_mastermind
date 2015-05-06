require 'mastermind/guess'

module Mastermind

  class RandomAI

    def next_guess(feedback)
      guess = ''
      4.times do
        guess += Guess::COLOURS.sample
      end
      guess
    end

  end

end
