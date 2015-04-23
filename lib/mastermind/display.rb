module Mastermind

  class Display

    WELCOME_MESSAGE = "Welcome to Mastermind!"
    START_PROMPT = "Start game? Make sure you have a code ready!"
    EXACT_MATCH_PROMPT = "Enter the exact number of matches: "
    UNEXACT_MATCH_PROMPT = "Enter the unexact number of matches: "
    GUESS_MESSAGE = "Player guess is: "

    def initialize(output = STDOUT, input = STDIN)
      @output = output
      @input = input
    end

    def display_welcome
      @output.puts(WELCOME_MESSAGE)  
      @output.puts(START_PROMPT)
    end

    def guess_message(guess)
      @output.puts(GUESS_MESSAGE+ guess)
    end

    def get_exact_matches
      @output.puts(EXACT_MATCH_PROMPT)
      @input.gets
    end

    def get_unexact_matches
      @output.puts(UNEXACT_MATCH_PROMPT)
      @input.gets
    end
  end

end
