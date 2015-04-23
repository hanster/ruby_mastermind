require 'spec_helper'

module Mastermind

  describe RandomAI do

    it "returns a random guess that is 4 characters long" do
      ai = RandomAI.new
      expect(ai.next_guess(0, 0).length).to eq(4)
    end

    it "returns a guess and each character is one of RGOYBP" do
      ai = RandomAI.new
      guess = ai.next_guess(0, 0)

      guess.each_char do |char|
        expect(Guess::COLOURS).to include(char)
      end
    end

  end
end
