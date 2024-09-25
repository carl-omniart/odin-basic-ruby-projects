# frozen_string_literal: true

module Mastermind
  # Mastermind::Board is where the game logic comes together.
  class Board
    def initialize(rules)
      @rules   = rules
      @guesses = []
      @code    = nil
    end

    attr_reader :rules, :code

    def code=(code)
      rules.check_code code

      lower_shield
      @code = code
    end

    def ready?
      !!code
    end

    def solved?
      guesses.last.correct?
    end

    def out_of_guesses?
      guesses.size == rules.max_guesses
    end

    def over?
      solved? || out_of_guesses?
    end

    def score
      return 0 unless over?

      guesses.size + (solved? ? 0 : 1)
    end

    def add_guess(code)
      return if !ready? || over?

      guesses << Guess.new(code, self.code)
      raise_shield if over?
      guesses.last.feedback
    end

    def to_a
      guesses.map(&:to_a)
    end

    alias inspect to_a

    private

    attr_reader :guesses

    def lower_shield
      singleton_class.undef_method(:code=)
      private :code
    end

    def raise_shield
      public :code
    end
  end
end
