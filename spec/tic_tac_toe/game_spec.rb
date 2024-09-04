# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/tic_tac_toe'

RSpec.describe 'TicTacToe::Game class' do
  let(:new_game) { TicTacToe::Game.new }

  describe '::new' do
    it 'should return an instance of itself when new' do
      expect(TicTacToe::Game.new).to be_a(TicTacToe::Game)
    end
  end
end
