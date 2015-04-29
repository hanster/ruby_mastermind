require 'spec_helper'
require 'mastermind/minimax_ai'

module Mastermind

  describe MinimaxAi do

    it "starts with an initial guess of 'RRGG'" do
      ai = MinimaxAi.new
      expect(ai.next_guess(0, 0)).to eq('RRGG'.split(''))
    end

    it "initially start with all permutations available" do
      ai = MinimaxAi.new
      expect(ai.available_permutations.count).to eq(1296)
    end

    it "filter out all from the set that will not have the same feedback as the guess" do
      available_guesses = ['RRRR'.split(''), 'BBBR'.split(''), 'RBBB'.split('')]
      guess = 'BBBB'.split('')
      feedback = [0, 0]

      ai = MinimaxAi.new
      filtered_out = ai.filter_based_on_score(available_guesses, feedback, guess)

      expect(filtered_out).to eq(['RRRR'.split('')])
    end

    it "eliminates 0 if the guess is the same" do
      available_guesses = ['RRRR'.split('')]
      guess = 'RRRR'.split('')
      feedback = [4, 0]

      ai = MinimaxAi.new
      number_eliminated = ai.number_eliminated(available_guesses, feedback, guess)

      expect(number_eliminated).to eq(0)
    end

    it "returns 2 for the number eliminated for a simple case" do
      available_guesses = ['RRRR'.split(''), 'BBBR'.split(''), 'RBBB'.split('')]
      guess = 'BBBB'.split('')
      feedback = [0, 0]

      ai = MinimaxAi.new
      number_eliminated = ai.number_eliminated(available_guesses, feedback, guess)

      expect(number_eliminated).to eq(2)
    end

    it "eliminates 3 for another simple case" do
      available_guesses = ['RRRR'.split(''), 'BBBR'.split(''), 'RBBB'.split('')]
      guess = 'BBBB'.split('')
      feedback = [1, 0]

      ai = MinimaxAi.new
      number_eliminated = ai.number_eliminated(available_guesses, feedback, guess)

      expect(number_eliminated).to eq(3)
    end

    it "eliminates 1 when 2 cases match the feedback" do
      available_guesses = ['RRRR'.split(''), 'BBBR'.split(''), 'RBBB'.split('')]
      guess = 'BBBB'.split('')
      feedback = [3, 0]

      ai = MinimaxAi.new
      number_eliminated = ai.number_eliminated(available_guesses, feedback, guess)

      expect(number_eliminated).to eq(1)
    end

    it "returns the minimum score for a guess from all possible feedback" do
      available_guesses = ['RRRR'.split(''), 'BBBR'.split(''), 'RBBB'.split('')]
      guess = 'BBBB'.split('')

      ai = MinimaxAi.new
      min_number_eliminated = ai.min_number_eliminated_from_all_possible_feedback(available_guesses, guess)

      expect(min_number_eliminated).to eq(1)
    end

    it "filter out the max values from a hash map of possible guesses" do
      ai = MinimaxAi.new
      minimax_scores = {
        'RRRR'.split('') => 3,
        'BBBB'.split('') => 2,
        'YYYY'.split('') => 1,
        'OOOO'.split('') => 3
      }

      best_candidates = ai.select_best_candidates(minimax_scores)
      expect(best_candidates).to eq(['RRRR'.split(''), 'OOOO'.split('')])
    end

    it "gets the next_guess correctly" do
      ai = MinimaxAi.new
      ai.next_guess(0,0)
      next_guess = ai.next_guess(2,0)
      
      expect(next_guess).to eq('RROY'.split(''))
      
      next_guess = ai.next_guess(1,0)
      expect(next_guess).to eq('RBGB'.split(''))
    end

  

  end
end
