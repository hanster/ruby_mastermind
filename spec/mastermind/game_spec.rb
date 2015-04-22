require 'spec_helper'

module Mastermind

  class StubDisplay
    attr_accessor :display_welcome_times_called, :get_exact_matches_times_called, :get_unexact_matches_times_called

   def initialize
     @display_welcome_times_called = 0
     @get_unexact_matches_times_called = 0
     @get_exact_matches_times_called = 0
   end

    def display_welcome
      @display_welcome_times_called += 1
    end

    def get_exact_matches
      @get_exact_matches_times_called += 1
      @exact_matches
    end

    def get_unexact_matches
      @get_unexact_matches_times_called += 1
      @unexact_matches
    end
    
    def set_exact_matches(number)
      @exact_matches = number
    end
    
    def set_unexact_matches(number)
      @unexact_matches = number
    end
  end

  class StubAI
    attr_reader :next_guess_times_called

    def initialize
      @next_guess_times_called = 0
    end
    def next_guess
      @next_guess_times_called += 1
    end
  end


  describe Game do
    let(:stubDisplay) { StubDisplay.new }
    let(:game) { Game.new(stubDisplay) }

    describe "#start" do
      it "sends a welcome message when the game starts" do
        expect(stubDisplay.display_welcome_times_called).to eq(0)
        game.start
        expect(stubDisplay.display_welcome_times_called).to eq(1)
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

      xit "gets the next best guess forom the AI" do
        game = Game.new(stubDisplay, stubAI)
        game.start
        
        game.guess

      end
    end

    describe "#over?" do
      it "is over when the exact matches is 4" do
        stubDisplay.set_exact_matches(4)
        game.start

        expect(game.over?).to be false
        game.get_exact_matches

        expect(game.over?).to be true
        expect(stubDisplay.get_exact_matches_times_called).to eq(1)
      end

      it "is not over if the exact matches input is not 4" do
        stubDisplay.set_exact_matches(0)
        game.start

        expect(game.over?).to be false
        game.get_exact_matches
        expect(game.over?).to be false
        expect(stubDisplay.get_exact_matches_times_called).to eq(1)
      end

    end

    describe "#get_unexact_matches" do
      it "gets user input when #get_unexact_matches is called" do
        stubDisplay.set_unexact_matches(0)
        game.start

        expect(stubDisplay.get_unexact_matches_times_called).to eq(0)
        game.get_unexact_matches
        expect(stubDisplay.get_unexact_matches_times_called).to eq(1)
      end
    end

  end
end
