module Mastermind
  class Game
    def initialize output
      @output = output
    end

    def start
      @output.puts("Welcome to Mastermind!")  
    end
  end
end
