require 'spec_helper'

module Mastermind

  class TestGame
    attr_reader :turn_played
    attr_reader :play_turn_count, :start_count
    attr_accessor :running

    def initialize
      @turn_played = false
      @play_turn_count = 0
      @start_count = 0
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

  end

  describe GameLoop do

    let (:game) { TestGame.new }
    let(:game_loop) { GameLoop.new(game) }

    it "does nothing when the game is stopped" do
      game.running = [false]

      game_loop.run

      expect(game.turn_played).to be false

    end
    
    it "runs play_turn once before the game is stopped" do
      game.running = [true, false]

      game_loop.run

      expect(game.turn_played).to be true
      expect(game.play_turn_count).to be(1)
    end
    
    it "plays a turn until the game is no longer running" do
      game.running = [true, true, false]
      
      game_loop.run

      expect(game.play_turn_count).to be(2)
    end

    it "starts the game before the game loop" do
      game.running = [false]

      game_loop.run

      expect(game.start_count).to be (1)
    end
  end
end
