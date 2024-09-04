# frozen_string_literal: true

module TicTacToe
  # Controller ...
  class Game
    POSTS = {
      welcome: [
        '#############################',
        '#  Welcome to TIC-TAC-TOE!  #',
        '#  Created by Carl Omniart  #',
        '#############################'
      ],
      goodbye: [
        '#############################',
        '#      Good-Bye! XOXOX      #',
        '#############################'
      ],
      instructions: [
        '7|8|9   Q|W|E     I: Instructions',
        '-+-+-   -+-+-   Esc: Exit        ',
        '4|5|6   A|S|D                    ',
        '-+-+-   -+-+-                    ',
        '1|2|3   Z|X|C                    '
      ]
    }.transform_values(&:freeze)

    KEYPRESSES = [
      %w[1 2 3
         4 5 6
         7 8 9].each_with_index.to_h { |char, index| [char, index] },
      %w[Z X C
         A S D
         Q W E].each_with_index.to_h { |char, index| [char, index] },
      { 'I' => :post_instructions,
        "\e" => :exit }
    ].reduce({}) { |memo, hash| memo.merge hash }.freeze

    def initialize
      self.io    = IO.new(post_spacing: 1, char_transform: :upcase)
      self.marks = %i[x o]
      self.grid  = nil
    end

    attr_reader :io, :marks, :grid

    # rubocop: disable Metriks/MethodLength

    def play
      post_welcome
      post_instructions

      until :hell == :frozen
        setup_game

        until grid.over?
          post_grid
          post_active_mark

          move = request_move
          break if move == :exit

          make_move move
        end
        post_result

        break unless play_again?
      end

      post_goodbye
      self
    end

    def inspect
      "<#{self.class}: #{object_id}>"
    end

    # rubocop: enable Metriks/MethodLength

    private

    attr_writer :io, :marks, :grid

    def post_welcome
      io.post(*POSTS[:welcome])
    end

    def post_instructions
      io.post(*POSTS[:instructions])
    end

    def post_goodbye
      io.post(*POSTS[:goodbye])
    end

    def post_grid
      io.post grid.to_s
    end

    def post_active_mark
      io.post "#{grid.active_mark.upcase}'s move."
    end

    def post_result
      post_grid
      io.post "Cat's game." if grid.cats?
      io.post "#{grid.winner.upcase} wins!" if grid.winner?
    end

    def setup_game
      self.grid = Grid.new(*marks)
      marks.reverse!
    end

    def make_move(move)
      case move
      when Integer
        grid.draw move
      when Symbol
        send move
      else
        raise StandardError, 'This should not be happening!'
      end
    end

    def request_move
      char = io.request_char 'Move:', *valid_keypresses
      KEYPRESSES[char]
    end

    def play_again?
      io.request_char('Play again? (Y)es or (N)o:', 'Y', 'N') == 'Y'
    end

    def valid_keypresses
      marked_squares = grid.marked_squares
      KEYPRESSES.reject { |_keypress, move| marked_squares.include? move }.keys
    end
  end
end
