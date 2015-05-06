module Mastermind
  class ScoringFeedback
    attr_accessor :exact_matches, :unexact_matches
    
    def initialize(exact, unexact)
      @exact_matches = exact
      @unexact_matches = unexact
    end

    def ==(other)
      (self.exact_matches == other.exact_matches) && (self.unexact_matches == other.unexact_matches)
    end
  end
end
