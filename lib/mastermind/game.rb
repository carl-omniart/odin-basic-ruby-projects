# frozen_string_literal: true

module Mastermind
  # Mastermind::Game ...
  class Game
    def initialize(player1, player2, rules: Rules.new)
      @players = [player1, player2]
      @rules   = rules
      @board   = Board.new rules

      players.each { |player| player.explain rules }
    end

    attr_reader :players, :board

    def code_maker
      players.first
    end

    def code_breaker
      players.last
    end

    def make_code
      board.code = code_maker.make_code
      self
    end

    def break_code
      code_breaker.examine board.guesses
      board.add_guess code_breaker.break_code
      self
    end

    def play
      make_code
      break_code until board.over?
      board.score
    end
  end
end
