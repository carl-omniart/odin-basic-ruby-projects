# frozen_string_literal: true

module TicTacToe
  # TicTacToe::Grid is a big hashtag for competitive doodling
  class Grid
    SETS = [
      [6, 7, 8], # rows
      [3, 4, 5],
      [0, 1, 2],
      [8, 5, 2], # columns
      [7, 4, 1],
      [6, 3, 0],
      [2, 4, 6], # diagonals
      [0, 4, 8]
    ].map(&:freeze)

    def initialize(first_mark, second_mark)
      @marks   = [first_mark, second_mark]
      @squares = Array.new 9
    end

    attr_reader :marks, :squares

    def active_mark
      marks.first
    end

    def empty_squares
      squares.each_index.select { |index| squares[index].nil? }
    end

    def marked_squares
      squares.each_index.reject { |index| squares[index].nil? }
    end

    def each_set
      return enum_for(:each_set) unless block_given?

      SETS.each { |set| yield set.map { |index| squares[index] } }
    end

    def winning_set
      each_set.find { |set| marks.any? { |mark| set.all? mark } }
    end

    def winner
      winning_set&.first
    end

    def full?
      squares.all?
    end

    def winner?
      !!winner
    end

    def cats?
      full? && !winner?
    end

    def over?
      full? || winner?
    end

    def draw(index)
      raise(StandardError, "Game's over, bud") if over?
      raise(StandardError, 'Occupied!') if squares[index]

      squares[index] = active_mark
      marks.reverse!
      self
    end

    def to_a
      squares.each_slice(3).to_a
    end

    def to_s
      squares
        .map { |square| square ? square.to_s : ' ' }
        .each_slice(3)
        .map { |row| row.join '|' }
        .reverse # => ['6|7|8', '3|4|5', '0|1|2']
        .join("\n-+-+-\n")
    end
  end
end
