require 'mastermind/display'
require 'mastermind/random_ai'
require 'mastermind/guess'

module Mastermind
  class Game
    MAX_TURNS = 10
    EXACT_MATCHES_WIN = Guess::LENGTH
    attr_reader :number_of_turns

    def initialize (display = Display.new, ai = RandomAi.new)
      @ai_guesser = ai
      @display = display
      @current_exact_matches = -1
      @current_unexact_matches = -1
      @number_of_turns = 0
    end

    def start
      display.display_welcome
      @number_of_turns = 0
    end

    def play_turn
      @number_of_turns += 1
      display.guess_message(make_a_guess, number_of_turns)
      capture_feedback
    end

    def over? (number_of_turns, exact_matches)
      number_of_turns >= MAX_TURNS || correctly_guessed?(exact_matches)
    end

    def running?
      !over?(number_of_turns, current_exact_matches)
    end

    def end_game
      if correctly_guessed?(current_exact_matches)
        display.win_message
      else
        display.lose_message
      end
      display.thanks_message
    end

    private

    attr_reader :display, :ai_guesser, 
      :current_exact_matches, :current_unexact_matches

    def capture_feedback
      @current_exact_matches = display.prompt_exact_matches
      @current_unexact_matches = display.prompt_unexact_matches
    end

    def make_a_guess
      ai_guesser.next_guess(ScoringFeedback.new(current_exact_matches, current_unexact_matches))
    end

    def correctly_guessed?(exact_matches)
      exact_matches == EXACT_MATCHES_WIN
    end
  end
end
