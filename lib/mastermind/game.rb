require 'mastermind/display'
require 'mastermind/random_ai'
require 'mastermind/guess'

module Mastermind
  class Game
    MAX_GUESSES = 10
    EXACT_MATCHES_WIN = Guess::LENGTH
    attr_reader :number_of_guesses

    def initialize (display = Display.new, ai = RandomAI.new)
      @ai_guesser = ai
      @display = display
      @current_exact_matches = 0
      @current_unexact_matches = 0
      @number_of_guesses = 0
    end

    def start
      display.display_welcome
      @number_of_guesses = 0
    end

    def play_turn
      next_guess = guess
      display.guess_message(next_guess, number_of_guesses)
      @current_exact_matches = display.prompt_exact_matches
      @current_unexact_matches = display.prompt_unexact_matches
    end

    def over? (number_of_guesses, exact_matches)
      number_of_guesses >= MAX_GUESSES || exact_matches == EXACT_MATCHES_WIN
    end

    def running?
      !over?(number_of_guesses, current_exact_matches)
    end

    private

    attr_reader :display, :ai_guesser, 
      :current_exact_matches, :current_unexact_matches

    def guess
      @number_of_guesses += 1
      ai_guesser.next_guess(ScoringFeedback.new(current_exact_matches, current_unexact_matches))
    end
  end
end
