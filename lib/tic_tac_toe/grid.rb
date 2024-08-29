# frozen_string_literal: true

module TicTacToe
  # It's like a hashtag but bigger
  class Grid
    def initialize
      @squares = Array.new(3) { Array.new(3) { Square.new } }
    end

    attr_reader :squares
  end
end
