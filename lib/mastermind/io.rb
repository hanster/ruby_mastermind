module Mastermind

  class IO

    def initialize(output = STDOUT, input = STDIN)
      @output = output
      @input = input
    end

    def display_welcome
      @output.puts("Welcome to Mastermind!")  
      @output.puts("Start game? Make sure you have a code ready!")
    end

    def get_exact_matches
      @output.puts("Enter the exact number of matches: ")
      @input.gets
    end

    def get_unexact_matches
      @output.puts("Enter the unexact number of matches: ")
      @input.gets
    end
  end

end
