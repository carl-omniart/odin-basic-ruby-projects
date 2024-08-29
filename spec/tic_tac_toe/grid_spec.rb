# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/tic_tac_toe'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'TicTacToe::Grid class' do
  let(:grid) { TicTacToe::Grid.new }
  let(:squares) { TicTacToe::Grid.new.squares }

  describe '.new' do
    it 'returns an instance of TicTacToe::Grid' do
      expect(grid).to be_a(TicTacToe::Grid)
    end
  end

  describe '.turn' do
    xit 'alternately returns "X" then "O"' do
      expect(grid.turn).to eq('X')
      expect(grid.play(0).turn).to eq('O')
      expect(grid.play(0, 4).turn).to eq('X')
      expect(grid.play(4, 9, 3).turn).to eq('O')
    end
  end

  describe '.squares' do
    xit 'returns a 3x3 array of squares' do
      expect(squares.size).to eq(3)
      squares.each { |row| expect(row.size).to eq(3) }
    end
  end

  describe '.play' do
    xit 'takes an Integer between 1 and 9' do
      expect { grid.play 9 }.not_to raise_error
    end

    xit 'raises an error if given anything else' do
      expect { grid.play 0 }.to raise_error(TypeError)
      expect { grid.play 10 }.to raise_error(TypeError)
      expect { grid.play '2' }.to raise_error(TypeError)
      expect { grid.play nil }.to raise_error(TypeError)
    end
  end

  # describe '.to_s' do
  #   it 'displays a pretty grid' do
  #   end
  # end
end

# rubocop: enable Metrics/BlockLength
