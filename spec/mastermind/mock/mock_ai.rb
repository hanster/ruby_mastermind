require 'spec_helper'

module Mastermind
  module Mock
    class MockAI
      attr_reader :next_guess_times_called

      def initialize
        @next_guess_times_called = 0
      end
      def next_guess(prev_exact_matches, prev_unexact_matches)
        @next_guess_times_called += 1
        "RRRR"
      end
    end
  end
end

