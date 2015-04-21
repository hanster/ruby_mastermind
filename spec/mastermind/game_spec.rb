require 'spec_helper'

module Mastermind

  class StubInput
    attr_accessor :times_user_input_called, :inputs

    def initialize
      self.times_user_input_called = 0
    end

    def get_user_input
      self.times_user_input_called += 1
      @inputs.shift
    end
  end

  describe Game do
    let(:output) { double('output').as_null_object }
    let(:input) { StubInput.new }
    let(:game) { Game.new(output) }
    
    describe "#start" do
      it "sends a welcome message" do
        expect(output).to receive(:puts).with("Welcome to Mastermind!")
        game.start
      end

      it "prompts to computer to make a guess" do
        expect(output).to receive(:puts).with("Start game? Make sure you have a code ready!")
        game.start
      end

      it "starts with a guess counter at 0" do
        game.start
        
        expect(game.number_of_guesses).to eq(0)
      end
    end

    describe "#guess" do
      it "returns a random guess" do
        game.start
        expect(game.guess).to eq("RRRR")
      end

      it "increments the counter to 1 when the computer makes a guess" do
        game.start
        game.guess

        expect(game.number_of_guesses).to eq(1)
      end

      it "increments the counter each time the computer makes a guess" do
        game.start
        game.guess
        game.guess

        expect(game.number_of_guesses).to eq(2)
      end

      it "sets the game as over when there are 10 guesses" do
        game.start

        10.times { game.guess }

        expect(game.over?).to be true
      end
    end

    describe "#over?" do
      it "is over when the exact matches is 4" do
        input.inputs = [4]
        game = Game.new(output, input)
        game.start

        expect(game.over?).to be false
        game.get_exact_matches
        
        expect(game.over?).to be true
        expect(input.times_user_input_called).to eq(1)
      end

      it "is not over if the exact matches input is not 4" do
        input.inputs = [0]
        game = Game.new(output, input)
        game.start

        expect(game.over?).to be false
        game.get_exact_matches
        expect(game.over?).to be false
        expect(input.times_user_input_called).to eq(1)
      end

    end

    describe "#get_unexact_matches" do
      it "gets user input when #get_unexact_matches is called" do
        input.inputs = [0]
        game = Game.new(output, input)
        game.start

        expect(input.times_user_input_called).to eq(0)
        game.get_unexact_matches
        expect(input.times_user_input_called).to eq(1)
      end
    end
  end

end
