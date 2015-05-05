require 'spec_helper'

module Mastermind
  module Mock
    class Display

      attr_accessor :display_welcome_times_called,
        :prompt_exact_matches_times_called,
        :prompt_unexact_matches_times_called,
        :guess_message_times_called,
        :thanks_message_times_called,
        :win_message_times_called,
        :lose_message_times_called

      def initialize
        @display_welcome_times_called = 0
        @guess_message_times_called = 0
        @prompt_unexact_matches_times_called = 0
        @prompt_exact_matches_times_called = 0
        @thanks_message_times_called = 0
        @win_message_times_called = 0
        @lose_message_times_called = 0
      end

      def display_welcome
        @display_welcome_times_called += 1
      end

      def guess_message(guess, guess_number)
        @guess_message_times_called += 1
      end

      def prompt_exact_matches
        @prompt_exact_matches_times_called += 1
        @exact_matches
      end

      def prompt_unexact_matches
        @prompt_unexact_matches_times_called += 1
        @unexact_matches
      end

      def set_exact_matches(number)
        @exact_matches = number
      end

      def set_unexact_matches(number)
        @unexact_matches = number
      end

      def thanks_message
        @thanks_message_times_called += 1
      end

      def win_message
        @win_message_times_called += 1
      end

      def lose_message
        @lose_message_times_called += 1
      end
    end
  end
end

