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
    def next_guess(prev_exact_matches, prev_unexact_matches)
      @next_guess_times_called += 1
      "RRRR"
    end
  end


  describe Game do
    let(:stub_ai) { StubAI.new }
    let(:stub_display) { StubDisplay.new }
    let(:game) { Game.new(stub_display) }

    describe "#start" do
      it "sends a welcome message when the game starts" do
        expect(stub_display.display_welcome_times_called).to eq(0)
        game.start
        expect(stub_display.display_welcome_times_called).to eq(1)
      end

      it "starts with a guess counter at 0" do
        game.start

        expect(game.number_of_guesses).to eq(0)
      end
    end

    describe "#guess" do
      it "returns a random guess" do
        game = Game.new(stub_display, stub_ai)
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

      it "is game over when there are 10 guesses" do
        expect(game.over?(10, 0)).to be true
      end

      it "gets the next best guess forom the AI" do
        game = Game.new(stub_display, stub_ai)
        game.start
        
        expect(stub_ai.next_guess_times_called).to eq(0)
        game.guess
        expect(stub_ai.next_guess_times_called).to eq(1)
      end
    end

    describe "#over?" do
      it "is over when the exact matches is 4" do
        expect(game.over?(1, 4)).to be true
      end

      it "is not over if the exact matches input is not 4" do
        expect(game.over?(1, 0)).to be false
      end

    end

    describe "#play_turn" do
      it "asks the AI for a guess" do
        game = Game.new(stub_display, stub_ai)

        game.play_turn
        expect(stub_ai.next_guess_times_called).to eq(1)
      end
      
      it "calls display.get_exact_matches" do
        stub_display.set_exact_matches(0)
        game = Game.new(stub_display, stub_ai)

        game.play_turn
        expect(stub_display.get_exact_matches_times_called).to eq(1)
      end

 
      it "calls display.get_unexact_matches" do
        stub_display.set_unexact_matches(0)
        game = Game.new(stub_display, stub_ai)

        game.play_turn
        expect(stub_display.get_unexact_matches_times_called).to eq(1)
      end

    end
  end
end
