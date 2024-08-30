# frozen_string_literal: true

module TicTacToe
  # TicTacToe::Grid is a big hashtag for competitive doodling
  class Grid
    SETS = [
      [[0, 0], [0, 1], [0, 2]], # columns
      [[1, 0], [1, 1], [1, 2]],
      [[2, 0], [2, 1], [2, 2]],
      [[0, 0], [1, 0], [2, 0]], # rows
      [[0, 1], [1, 1], [2, 1]],
      [[0, 2], [1, 2], [2, 2]],
      [[0, 0], [1, 1], [2, 2]], # diagonals
      [[2, 0], [1, 1], [0, 2]]
    ].map { |set| set.each(&:freeze) }

    def initialize(first_player = :x, second_player = :o)
      @squares = Array.new(3) { Array.new(3) }
      @playing = first_player
      @waiting = second_player
      @winner  = nil
    end

    attr_reader :squares, :playing, :waiting, :winner

    # rubocop: disable Naming/MethodParameterName

    def draw(x, y)
      raise(StandardError, "Game's over, bud") if over?
      return unless squares[y][x].nil?

      squares[y][x] = playing

      check_for_winner
      next_turn
      self
    end

    # rubocop: enable Naming/MethodParameterName

    def full?
      squares.flatten.none?(&:nil?)
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

    def wins?(player)
      SETS.any? do |set|
        set.all? { |x, y| squares[y][x] == player }
      end
    end

    def to_s
      rows = squares.map do |row|
        row.map { |square| square.nil? ? ' ' : square.to_s }.join '|'
      end
      line = '-+-+-'
      [rows[2], line, rows[1], line, rows[0]].join "\n"
    end

    private

    def check_for_winner
      [playing, waiting].each { |player| @winner = player if wins?(player) }
      winner
    end

    def next_turn
      @playing, @waiting = @waiting, @playing
      self
    end
  end
end
