# frozen_string_literal: true

module TicTacToe
  # Nice place to put an X or an O
  class Square
    def initialize
      @char = ''
    end

    def to_s
      @char
    end

    def set(char)
      char = char.upcase
      @char = char if %w[X O].include? char
      self
    end

    def empty?
      @char.empty?
    end

    def x?
      @char == 'X'
    end

    def o?
      @char == 'O'
    end
  end
end
