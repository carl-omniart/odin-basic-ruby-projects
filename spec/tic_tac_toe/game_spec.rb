# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/tic_tac_toe'

RSpec.describe 'TicTacToe::Game class' do
  let(:new_game) { TicTacToe::Game.new }

  describe '::new' do
    it 'returns an instance of TicTacToe::Game' do
      expect(new_game).to be_a(TicTacToe::Game)
    end
  end
end
