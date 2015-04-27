require 'spec_helper'

module Mastermind
  module Mock
    class Display

      attr_accessor :display_welcome_times_called, 
        :get_exact_matches_times_called, 
        :get_unexact_matches_times_called,
        :guess_message_times_called

      def initialize
        @display_welcome_times_called = 0
        @guess_message_times_called = 0
        @get_unexact_matches_times_called = 0
        @get_exact_matches_times_called = 0
      end

      def display_welcome
        @display_welcome_times_called += 1
      end

      def guess_message(guess, guess_number)
        @guess_message_times_called += 1
      end

      def get_exact_matches
        @get_exact_matches_times_called += 1
        @exact_matches
      end

      def get_unexact_matches
        @get_unexact_matches_times_called += 1
        @unexact_matches
      end

      def set_exact_matches(number)
        @exact_matches = number
      end

      def set_unexact_matches(number)
        @unexact_matches = number
      end
    end
  end
end

