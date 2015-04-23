require 'spec_helper'

module Mastermind

  describe Display do
    let(:output) { StringIO.new }
    let(:input) { StubInput.new }
    let(:display) { Display.new(output, input) }

    describe "#display_welcome" do
      it "sends a welcome message" do
        display.display_welcome
        expect(output.string).to start_with("Welcome to Mastermind!")
      end

      it "displays the guess message" do
        guess = "RRRR"
        number_of_guesses = 1
        display.guess_message(guess, number_of_guesses)
        expect(output.string).to start_with("1: Player guess is: " + guess)
      end

      it "prompts to computer to make a guess" do
        display.display_welcome
        expect(output.string).to include("Start game? Make sure you have a code ready!")
      end
    end

    describe "#get_exact_matches" do
      it "outputs a prompt before getting user input" do
        input.inputs = [4]
        expect(display.get_exact_matches).to eq(4)
        expect(output.string).to start_with("Enter the exact number of matches: ")
      end
    end

    describe "#get_unexact_matches" do
      it "outputs a prompt before getting user input" do
        input.inputs = [4]
        expect(display.get_unexact_matches).to eq(4)
        expect(output.string).to start_with("Enter the unexact number of matches: ")
      end
    end

  end

  class StubInput
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
