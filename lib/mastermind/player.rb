# frozen_string_literal: true

module Mastermind
  # Mastermind::Player defines a generic player who makes random guesses.
  class Player
    def initialize(name)
      self.name = name
    end

    attr_accessor :name

    def new_game(game)
      @game = game
    end

    def make_code
      duplicates? ? Array.new(size) { pegs.sample } : pegs.sample(size)
    end

    def break_code
      make_code rules
    end

    private

    def pegs
      rules.code_pegs.tap { |pegs| pegs << nil if rules.blanks? }
    end

    def size
      rules.holes
    end

    def duplicates?
      rules.duplicates?
    end
  end
end
