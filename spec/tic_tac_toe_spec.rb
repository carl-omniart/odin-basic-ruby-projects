# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/tic_tac_toe'

require 'tic_tac_toe/game_spec'
require 'tic_tac_toe/grid_spec'

RSpec.describe 'TicTacToe module' do
  describe '::start_game' do
    it 'returns a new TicTacToe Game' do
      expect(TicTacToe.start_game).to be_a(TicTacToe::Game)
    end
  end
end
