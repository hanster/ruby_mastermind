module Mastermind
  class Game
    attr_reader :number_of_guesses

    def initialize output
      @output = output
    end

    def start
      @output.puts("Welcome to Mastermind!")  
      @output.puts("Start game? Make sure you have a code ready!")
      @number_of_guesses = 0
    end

    def guess
      @number_of_guesses += 1
      return "R R R R"
    end

    def over?
      @number_of_guesses >= 10
    end
  end
end
