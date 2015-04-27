require 'spec_helper'
require 'mastermind/game'

module Mastermind
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

  class StubDisplay

    attr_accessor :display_welcome_times_called, 
      :get_exact_matches_times_called, 
      :get_unexact_matches_times_called,
      :guess_message_times_called

    def initialize
      @display_welcome_times_called = 0
      @guess_message_times_called = 0
      @get_unexact_matches_times_called = 0
      @get_exact_matches_times_called = 0
    end

    def display_welcome
      @display_welcome_times_called += 1
    end

    def guess_message(guess, guess_number)
      @guess_message_times_called += 1
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

    describe "#over?" do
      it "is over when the exact matches is 4" do
        expect(game.over?(1, Game::EXACT_MATCHES_WIN)).to be true
      end

      it "is not over if the exact matches input is not 4" do
        expect(game.over?(1, 0)).to be false
      end

      it "is game over when there are 10 guesses" do
        expect(game.over?(Game::MAX_GUESSES, 0)).to be true
      end

    end

    describe "#play_turn" do
      it "asks the AI for a guess" do
        game = Game.new(stub_display, stub_ai)

        game.play_turn
        expect(stub_ai.next_guess_times_called).to eq(1)
      end

      it "calls display.guess_message" do
        game = Game.new(stub_display, stub_ai)

        game.play_turn
        expect(stub_display.guess_message_times_called).to eq(1)
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

    it "is running if the game has just started" do
      game.start

      expect(game.running?).to be true
    end
  end
end
