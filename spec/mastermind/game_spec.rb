require 'spec_helper'

module Mastermind

  class StubInput

    def initialize(inputs)
      @inputs = inputs
    end

    def get_user_input
      @inputs.shift
    end
  end

  describe Game do
    let(:output) { double('output').as_null_object }
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
        game = Game.new(output, StubInput.new([4]))
        game.start

        expect(game.over?).to be false
        game.get_exact_matches
        
        expect(game.over?).to be true
      end

      it "is not over if the exact matches input is not 4" do
        game = Game.new(output, StubInput.new([0]))
        game.start

        expect(game.over?).to be false
        game.get_exact_matches
        expect(game.over?).to be false
      end

    end
  end

end
