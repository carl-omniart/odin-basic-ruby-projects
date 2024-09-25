# frozen_string_literal: true

module Mastermind
  # Mastermind::Guess
  class Guess
    def initialize(guess_code, master_code)
      @code     = guess_code.pegs
      @feedback = guess_code.difference_from master_code
    end

    attr_reader :code,
                :feedback

    def correct?
      feedback.all?(:+)
    end

    def to_a
      [code, feedback]
    end
  end
end
