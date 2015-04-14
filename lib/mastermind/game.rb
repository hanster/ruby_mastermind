module Mastermind
  class Game
    def initialize output
      @output = output
    end

    def start
      @output.puts("Welcome to Mastermind!")  
      @output.puts("Start game? Make sure you have a code ready!")
    end
  end
end
