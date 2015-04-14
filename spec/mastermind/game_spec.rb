require 'spec_helper'

module Mastermind
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
        expect(game.guess).to eq("R R R R")
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

        expect(game.over?).to eq(true)
      end
    end
  end
end
