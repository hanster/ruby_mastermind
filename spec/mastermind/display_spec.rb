require 'spec_helper'
require 'mastermind/display'

module Mastermind
  describe Display do
    let(:output) { StringIO.new }
    let(:input) { StringIO.new("4\n") }
    let(:display) { Display.new(output, input) }

    describe "#display_welcome" do
      it "sends a welcome message" do
        display.display_welcome
        expect(output.string).to start_with("Welcome to Mastermind!")
      end

      it "displays the guess message" do
        guess = "RRRR"
        number_of_guesses = 1
        display.guess_message(guess.split(''), number_of_guesses)
        expect(output.string).to start_with("1: Player guess is: " + guess)
      end

      it "prompts to computer to make a guess" do
        display.display_welcome
        expect(output.string).to include("Start game? Make sure you have a code ready!")
      end
    end

    describe "#prompt_exact_matches" do
      # not sure how or if I should be testing the order of calls
      it "outputs a prompt before getting user input" do
        expect(display.prompt_exact_matches).to eq(4)
        expect(output.string).to start_with("Enter the exact number of matches: ")
      end

      it "reads in values until it has a valid number 0-4" do
        input = StringIO.new("a\n4\n")
        display = Display.new(output, input)
        expect(display.prompt_exact_matches).to eq(4)
        expect(output.string).to include("Invalid input. 0-4 are valid.")
      end

    end

    describe "#prompt_unexact_matches" do
      it "outputs a prompt before getting user input" do
        expect(display.prompt_unexact_matches).to eq(4)
        expect(output.string).to start_with("Enter the unexact number of matches: ")
      end

      it "reads in values until it has a valid number 0-4" do
        input = StringIO.new("a\n4\n")
        display = Display.new(output, input)
        expect(display.prompt_unexact_matches).to eq(4)
      end
    end
  end
end
