require 'spec_helper'

module Mastermind
  describe Game do
    describe "#start" do
      it "sends a welcome message" do
        output = double('output')
        game = Game.new(output)

        expect(output).to receive(:puts).with("Welcome to Mastermind!")
        game.start
      end

    end
  end
end
