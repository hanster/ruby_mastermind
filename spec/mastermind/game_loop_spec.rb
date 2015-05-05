require 'spec_helper'
require 'mastermind/game_loop'

module Mastermind
  class TestGame
    attr_reader :turn_played
    attr_reader :play_turn_count, :start_count, :end_count
    attr_accessor :running

    def initialize
      @turn_played = false
      @play_turn_count = 0
      @start_count = 0
      @end_count = 0
    end

    def play_turn
      @turn_played = true
      @play_turn_count += 1
    end

    def running?
      @running.shift
    end
    
    def start
      @start_count += 1
    end

    def end_game
      @end_count += 1
    end
  end

  describe GameLoop do
    let (:game) { TestGame.new }
    let(:game_loop) { GameLoop.new(game) }

    def set_up_number_times_to_loop(game, num_loops)
      running_loop = [false]
      num_loops.times { running_loop.unshift(true) }

      game.running = running_loop
    end

    it "does nothing when the game is stopped" do
      set_up_number_times_to_loop(game, 0)
      game_loop.run

      expect(game.turn_played).to be false
    end
    
    it "runs play_turn once before the game is stopped" do
      set_up_number_times_to_loop(game, 1)
      game_loop.run

      expect(game.turn_played).to be true
      expect(game.play_turn_count).to be(1)
    end
    
    it "plays a turn until the game is no longer running" do
      set_up_number_times_to_loop(game, 2)
      game_loop.run

      expect(game.play_turn_count).to be(2)
    end

    it "starts the game before the game loop" do
      set_up_number_times_to_loop(game, 0)
      game_loop.run

      expect(game.start_count).to be (1)
    end

    it "calls the end method on the game when out of the game loop" do
      set_up_number_times_to_loop(game, 1)
      game_loop.run

      expect(game.end_count).to be (1)
    end
  end
end
