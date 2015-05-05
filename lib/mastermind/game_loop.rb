module Mastermind
  class GameLoop
    def initialize(game)
      @game = game
    end

    def run
      @game.start
      while game.running?
        game.play_turn
      end
      @game.end_game
    end

    private 

    attr_reader :game
  end
end
