# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/tic_tac_toe'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'TicTacToe::Grid class' do
  let(:new_grid) { TicTacToe::Grid.new }
  grids = {
    cats: [
      [1, 1], [0, 0], # oxx
      [2, 0], [0, 2], # xxo
      [0, 1], [2, 1], # oox
      [1, 2], [1, 0],
      [2, 2]
    ],
    x_wins: [
      [1, 1], [1, 2], # oox
      [2, 2], [0, 0], #  xx
      [2, 0], [0, 2], # o x
      [2, 1]
    ],
    o_wins: [
      [1, 0], [1, 1], # oxx
      [1, 2], [0, 2], # oo
      [2, 0], [0, 0], # oxx
      [0, 1], [2, 2]
    ]
  }.transform_values do |moves|
    moves.reduce(TicTacToe::Grid.new) { |grid, (x, y)| grid.draw x, y }
  end

  describe '::new' do
    it 'returns an instance of TicTacToe::Grid' do
      expect(new_grid).to be_a(TicTacToe::Grid)
    end
  end

  describe '#playing' do
    it 'returns active player' do
      grid = new_grid
      expect(grid.playing).to eq(:x)
      expect(grid.draw(1, 1).playing).to eq(:o)
      expect(grid.draw(0, 1).playing).to eq(:x)
    end
  end

  describe '#waiting' do
    it 'returns inactive player' do
      grid = new_grid
      expect(grid.waiting).to eq(:o)
      expect(grid.draw(0, 1).waiting).to eq(:x)
      expect(grid.draw(2, 0).waiting).to eq(:o)
    end
  end

  describe '#squares' do
    it 'returns a 3x3 array' do
      squares = new_grid.squares
      expect(squares.size).to eq(3)
      squares.each { |row| expect(row.size).to eq(3) }
    end
  end

  describe '#draw' do
    it 'can draw symbol in square' do
      grid    = new_grid
      squares = grid.squares

      expect(squares[2][1]).to be_nil
      grid.draw 1, 2
      expect(squares[2][1]).to eq(:x)

      expect(squares[0][2]).to be_nil
      grid.draw 2, 0
      expect(squares[0][2]).to eq(:o)
    end

    it 'advances turn to next player' do
      grid = new_grid
      expect(grid.playing).to eq(:x)
      expect(grid.waiting).to eq(:o)

      grid.draw 1, 1
      expect(grid.playing).to eq(:o)
      expect(grid.waiting).to eq(:x)
    end

    it 'returns self' do
      expect(new_grid.draw(1, 1)).to be_a(TicTacToe::Grid)
    end
  end

  describe '#full?' do
    it 'returns true if the grid is full' do
      expect(grids[:cats]).to be_full
    end

    it 'returns false if grid has empty squares' do
      expect(new_grid).not_to be_full
    end
  end

  describe '#winner?' do
    it 'return true if there is a winner' do
      expect(grids[:x_wins]).to be_winner
      expect(grids[:o_wins]).to be_winner
    end

    it 'otherwise returns false' do
      expect(grids[:cats]).not_to be_winner
    end
  end

  describe '#cats?' do
    it 'returns true if grid is full with no winner' do
      expect(grids[:cats]).to be_cats
    end

    it 'otherwise returns false' do
      expect(new_grid).not_to be_cats
      expect(grids[:x_wins]).not_to be_cats
      expect(grids[:o_wins]).not_to be_cats
    end
  end

  describe '#over?' do
    it 'returns true if winner? or full?' do
      expect(grids[:cats]).to be_over
      expect(grids[:x_wins]).to be_over
      expect(grids[:o_wins]).to be_over
    end

    it 'otherwise returns false' do
      expect(new_grid).not_to be_over
    end
  end

  describe '#wins?(player)' do
    it 'returns true if player has won' do
      expect(grids[:x_wins].wins?(:x)).to be(true)
      expect(grids[:o_wins].wins?(:o)).to be(true)
    end

    it 'otherwise returns false' do
      expect(grids[:x_wins].wins?(:o)).to be(false)
      expect(grids[:o_wins].wins?(:x)).to be(false)
      expect(grids[:cats].wins?(:o)).to be(false)
      expect(new_grid.wins?(:x)).to be(false)
    end
  end

  describe '#to_s' do
    it 'displays a pretty grid' do
      pretty_grid = [
        'o|x|x',
        '-+-+-',
        'x|x|o',
        '-+-+-',
        'o|o|x'
      ].join "\n"

      expect(grids[:cats].to_s).to eq(pretty_grid)
    end
  end
end

# rubocop: enable Metrics/BlockLength
