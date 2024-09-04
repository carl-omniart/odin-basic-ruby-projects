# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/tic_tac_toe'

require 'tic_tac_toe/game_spec'
require 'tic_tac_toe/io_spec'
require 'tic_tac_toe/grid_spec'

RSpec.describe 'TicTacToe module' do
  describe '::start_game' do
    xit 'returns a new TicTacToe Game' do
      # Don't know how to sequence getch and get a return value.
    end
  end
end
