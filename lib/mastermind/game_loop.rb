module Mastermind

  class GameLoop

    def initialize(game)
      @game = game
    end

    def run
      @game.start
      while @game.running?
        @game.play_turn
      end
    end

  end

end
