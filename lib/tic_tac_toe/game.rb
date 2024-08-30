# frozen_string_literal: true

module TicTacToe
  # TicTacToe::Game handles the input and output
  class Game
    COORDINATES = {
      '1' => [0, 0],
      '2' => [1, 0],
      '3' => [2, 0],
      '4' => [0, 1],
      '5' => [1, 1],
      '6' => [2, 1],
      '7' => [0, 2],
      '8' => [1, 2],
      '9' => [2, 2]
    }.transform_values { |location| location.freeze }

    NINE_KEY = [
      ['7|8|9'],
      ['-+-+-'],
      ['4|5|6'],
      ['-+-+-'],
      ['1|2|3']
    ]

    def initialize
      @grid = Grid.new
    end

    attr_reader :grid

    def start
      until grid.over?
        log_status
        choice = player_choice
        break if choice == 'x'

        coords = COORDINATES[choice]
        grid.draw(*coords) if coords
      end

      log_result
      self
    end

    private

    def log(message)
      puts message
      puts
    end

    def log_status
      log grid
      log NINE_KEY
      log "#{grid.playing.capitalize}'s turn"
    end

    def log_result
      log grid
      log "#{grid.winner.capitalize} wins!" if grid.winner?
      log 'Cats game.' if grid.cats?
    end

    def player_choice
      log '1-9: Choose Sqaure, X: Exit, N: Toggle 9-Key'
      $stdin.getch.downcase
    end
  end
end
