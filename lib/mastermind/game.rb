module Mastermind
  class Game
    MAX_GUESSES = 10
    EXACT_MATCHES_WIN = 4
    attr_reader :number_of_guesses

    def initialize (display = Display.new, ai = RandomAI.new)
      @ai_guesser = ai
      @display = display
      @exact_matches = 0
      @unexact_matches = 0
      @number_of_guesses = 0
    end

    def start
      @display.display_welcome
      @number_of_guesses = 0
    end

    def play_turn
      @next_guess = guess
      @display.guess_message(@next_guess, @number_of_guesses)
      @exact_matches = @display.get_exact_matches
      @unexact_matches = @display.get_unexact_matches
    end

    def over? (number_of_guesses, exact_matches)
      number_of_guesses >= MAX_GUESSES || exact_matches == EXACT_MATCHES_WIN
    end

    def running?
      not over?(@number_of_guesses, @exact_matches)
    end

    private

    def guess
      @number_of_guesses += 1
      @ai_guesser.next_guess(@exact_matches, @unexact_matches)
    end

  end
  
end
