require 'spec_helper'

module Mastermind

  describe Display do
    let(:output) { double('output').as_null_object }
    let(:input) { StubInput.new }
    let(:display) { Display.new(output, input) }

    describe "#display_welcome" do
      it "sends a welcome message" do
        expect(output).to receive(:puts).with("Welcome to Mastermind!")
        display.display_welcome
      end

      it "prompts to computer to make a guess" do
        expect(output).to receive(:puts).with("Start game? Make sure you have a code ready!")
        display.display_welcome
      end
    end

    describe "#get_exact_matches" do
      it "outputs a prompt before getting user input" do
        input.inputs = [4]
        expect(output).to receive(:puts).with("Enter the exact number of matches: ")
        expect(display.get_exact_matches).to eq(4)
      end
    end

    describe "#get_unexact_matches" do
      it "outputs a prompt before getting user input" do
        input.inputs = [4]
        expect(output).to receive(:puts).with("Enter the unexact number of matches: ")
        expect(display.get_unexact_matches).to eq(4)
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
