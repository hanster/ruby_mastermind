module Mastermind
  class Display
    WELCOME_MESSAGE = "Welcome to Mastermind!"
    START_PROMPT = "Start game? Make sure you have a code ready!"
    EXACT_MATCH_PROMPT = "Enter the exact number of matches: "
    UNEXACT_MATCH_PROMPT = "Enter the unexact number of matches: "
    GUESS_MESSAGE = "Player guess is: "
    INVALID_INPUT_MESSAGE = "Invalid input. 0-4 are valid."

    def initialize(output = STDOUT, input = STDIN)
      @output = output
      @input = input
    end

    def display_welcome
      output.puts(WELCOME_MESSAGE)
      output.puts(START_PROMPT)
    end

    def guess_message(guess, number_of_guesses)
      output.puts("#{number_of_guesses}: #{GUESS_MESSAGE}#{guess.join('')}")
    end

    def prompt_exact_matches
      prompt_number_input(EXACT_MATCH_PROMPT)
    end

    def prompt_unexact_matches
      prompt_number_input(UNEXACT_MATCH_PROMPT)
    end

    private

    attr_reader :output, :input

    def display_invalid_input
      output.puts(INVALID_INPUT_MESSAGE)
    end

    def prompt_number_input(prompt)
      output.puts(prompt)
      value = validate_input(input.gets)
      return value if value
      display_invalid_input
      prompt_number_input(prompt)
    end

    def validate_input(input_value)
      input_value[/^[0-4]$/] && input_value.to_i
    end
  end
end
