require 'spec_helper'
require 'mastermind/game'
require 'mastermind/mock/ai'
require 'mastermind/mock/display'

module Mastermind
  describe Game do
    let(:mock_ai) { Mastermind::Mock::AI.new }
    let(:mock_display) { Mastermind::Mock::Display.new }
    let(:game) { Game.new(mock_display) }

    describe "#start" do
      it "sends a welcome message when the game starts" do
        expect(mock_display.display_welcome_times_called).to eq(0)
        game.start
        expect(mock_display.display_welcome_times_called).to eq(1)
      end

      it "starts with a guess counter at 0" do
        game.start

        expect(game.number_of_turns).to eq(0)
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
        expect(game.over?(Game::MAX_TURNS, 0)).to be true
      end

    end

    describe "#play_turn" do
      it "asks the AI for a guess" do
        game = Game.new(mock_display, mock_ai)

        game.play_turn
        expect(mock_ai.next_guess_times_called).to eq(1)
      end

      it "calls display.guess_message" do
        game = Game.new(mock_display, mock_ai)

        game.play_turn
        expect(mock_display.guess_message_times_called).to eq(1)
      end

      it "calls display.prompt_exact_matches" do
        mock_display.set_exact_matches(0)
        game = Game.new(mock_display, mock_ai)

        game.play_turn
        expect(mock_display.prompt_exact_matches_times_called).to eq(1)
      end

      it "calls display.prompt_unexact_matches" do
        mock_display.set_unexact_matches(0)
        game = Game.new(mock_display, mock_ai)

        game.play_turn
        expect(mock_display.prompt_unexact_matches_times_called).to eq(1)
      end

    end

    it "is running if the game has just started" do
      game.start

      expect(game.running?).to be true
    end

    describe "#end_game" do
      it "calls the display thanks for playing method" do
        game.end_game
        expect(mock_display.thanks_message_times_called).to eq(1)
      end

      it "calls display win message when correctly guess in 10" do
        game = Game.new(mock_display, mock_ai)
        9.times { game.play_turn}
        mock_display.set_exact_matches(4)
        game.play_turn

        expect(mock_ai.next_guess_times_called).to eq(10)
        game.end_game
        expect(mock_display.win_message_times_called).to eq(1)
      end

      it "calls the computer failed message if it didn't guess correctly in 10 guesses" do
        game = Game.new(mock_display, mock_ai)
        mock_display.set_exact_matches(0)
        10.times { game.play_turn }

        game.end_game
        expect(mock_display.win_message_times_called).to eq(0)
        expect(mock_display.lose_message_times_called).to eq(1)
      end
    end
  end
end
