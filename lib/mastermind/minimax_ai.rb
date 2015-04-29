require 'mastermind/guess'
require 'mastermind/code_score_calculator'

module Mastermind
  class MinimaxAi
    def initialize
      @initial_guess = true
      @set_of_guesses = Guess::ALL_PERMUTATIONS
      @current_guess = "RRGG".split('')
      @code_score_calc = Mastermind::CodeScoreCalculator.new
    end

    def next_guess(exact_matches, unexact_matches)
      if initial_guess
        @initial_guess = false
        return current_guess
      end
      feedback = [exact_matches, unexact_matches]

      @set_of_guesses = filter_based_on_score(set_of_guesses, feedback, current_guess)

      minimax_scores = Hash.new
      minimax_lower_bound = 0

      @set_of_guesses.each do |guess|
        minimax_scores[guess] = min_number_eliminated_from_all_possible_feedback(set_of_guesses, guess, minimax_lower_bound)
        minimax_lower_bound = minimax_scores[guess] if minimax_scores[guess] > minimax_lower_bound
      end

      @current_guess = select_best_guess(minimax_scores)
    end

    def select_best_candidates(minimax_scores)
      minimax_scores.inject([]) do |best_candidates, (guess, score)| 
        best_candidates << guess if score == minimax_scores.values.max
        best_candidates
      end
    end

    def filter_based_on_score(available_guesses, feedback, guess)
      available_guesses.select do |a_guess|
        feedback == code_score_calc.score(guess, a_guess)
      end
    end

    def number_eliminated(available_guesses, feedback, guess)
      available_guesses.count - filter_based_on_score(available_guesses, feedback, guess).count
    end

    def min_number_eliminated_from_all_possible_feedback(available_guesses, guess, minimax_lower_bound)
      Guess::POSSIBLE_FEEDBACK.inject(1296) do |min_eliminated, feedback|
        this_min = number_eliminated(available_guesses, feedback, guess)
        return this_min if this_min < minimax_lower_bound
        min_eliminated = this_min if this_min < min_eliminated
        min_eliminated
      end
    end

    private

    attr_reader :initial_guess, :set_of_guesses, :current_guess, :code_score_calc 

    def select_best_guess(minimax_scores)
      best_candidates = select_best_candidates(minimax_scores)
      best_candidates_in_set = best_candidates & set_of_guesses

      if best_candidates_in_set.count > 0
        @current_guess = best_candidates_in_set[0]
      else
        @current_guess = set_of_guesses[0]
      end
    end
  end
end
