module Mastermind
  class Game
    attr_reader :number_of_guesses

    def initialize (display = Display.new, ai = RandomAI.new)
      @ai_guesser = ai
      @display = display
      @exact_matches = 0
      @unexact_matches = 0
    end

    def start
      @display.display_welcome
      @number_of_guesses = 0
    end

    def play_turn
      @next_guess = @ai_guesser.next_guess(@exact_matches, @unexact_matches)
      @display.guess_message(@next_guess)
      @exact_matches = @display.get_exact_matches
      @unexact_matches = @display.get_unexact_matches
    end

    def guess
      @number_of_guesses += 1
      return @ai_guesser.next_guess(@exact_matches, @unexact_matches)
    end

    def over? (number_of_guesses, exact_matches)
      number_of_guesses >= 10 || exact_matches == 4
    end

  end
  
end
