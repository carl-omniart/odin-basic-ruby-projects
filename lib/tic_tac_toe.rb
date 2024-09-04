# frozen_string_literal: true

require_relative 'tic_tac_toe/game'
require_relative 'tic_tac_toe/io'
require_relative 'tic_tac_toe/grid'

# Truly, a warrior's game
module TicTacToe
  def self.play(...)
    TicTacToe::Game.new(...).play
  end
end
