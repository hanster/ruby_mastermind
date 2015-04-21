module Mastermind

  class IO

    def initialize(output)
      @output = output
    end

    def display_welcome
      @output.puts("Welcome to Mastermind!")  
      @output.puts("Start game? Make sure you have a code ready!")
    end
  end

end
