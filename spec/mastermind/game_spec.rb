require 'spec_helper'

module Mastermind
  describe Game do
    describe "#start" do
      let(:output) { double('output').as_null_object }
      let(:game) { Game.new(output) }

      it "sends a welcome message" do
        expect(output).to receive(:puts).with("Welcome to Mastermind!")
        game.start
      end

      it "prompts to computer to make a guess" do
        expect(output).to receive(:puts).with("Start game? Make sure you have a code ready!")
        game.start
      end

    end
  end
end
