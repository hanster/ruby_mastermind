require 'spec_helper'

module Mastermind
  module Mock
    class Input
      attr_accessor :times_user_input_called, :inputs

      def initialize
        self.times_user_input_called = 0
      end

      def gets
        self.times_user_input_called += 1
        @inputs.shift
      end
    end
  end
end
