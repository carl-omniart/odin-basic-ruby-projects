# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/tic_tac_toe'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'TicTacToe::Grid class' do
  let(:new_grid) { TicTacToe::Grid.new :x, :o }
  let(:partial) do
    [4, 0,
     2, 6,
     3].reduce(TicTacToe::Grid.new(:x, :o)) { |grid, move| grid.draw move }
  end

  let(:cats) do
    [4, 0,
     2, 6,
     3, 5,
     7, 1,
     8].reduce(TicTacToe::Grid.new(:x, :o)) { |grid, move| grid.draw move }
  end

  let(:x_wins) do
    [4, 7,
     8, 0,
     2, 6,
     5].reduce(TicTacToe::Grid.new(:x, :o)) { |grid, move| grid.draw move }
  end

  let(:o_wins) do
    [1, 4,
     7, 6,
     2, 0,
     3, 8].reduce(TicTacToe::Grid.new(:x, :o)) { |grid, move| grid.draw move }
  end

  it 'returns itself when you draw on it' do
    grid = new_grid
    expect(grid.draw(1)).to be(grid)
  end

  it 'displays a pretty grid' do
    pretty_grid = [
      'o|x|x',
      '-+-+-',
      'x|x|o',
      '-+-+-',
      'o|o|x'
    ].join "\n"

    expect(cats.to_s).to eq(pretty_grid)
  end

  it 'keeps track of turns' do
    grid = new_grid
    expect(grid.active_mark).to eq(:x)
    grid.draw 8
    expect(grid.active_mark).to eq(:o)
    grid.draw 1
    expect(grid.active_mark).to eq(:x)
  end

  it 'knows which squares are empty' do
    expect(partial.empty_squares).to eq([1, 5, 7, 8])
    expect(new_grid.empty_squares.size).to eq(9)
    expect(cats.empty_squares).to be_empty
  end

  it 'know which squares are marked' do
    expect(partial.marked_squares).to eq([0, 2, 3, 4, 6])
    expect(new_grid.marked_squares).to be_empty
    expect(cats.marked_squares.size).to eq(9)
  end

  context 'when game is in progress' do
    it "does not think it's done" do
      expect(new_grid).not_to be_over
      expect(partial).not_to be_over
    end

    it 'sees empty squares' do
      expect(new_grid).not_to be_full
      expect(partial).not_to be_full
    end

    it 'sees no cat' do
      expect(new_grid).not_to be_cats
      expect(partial).not_to be_cats
    end

    it 'sees no winner' do
      expect(new_grid).not_to be_winner
      expect(partial).not_to be_winner
      expect(new_grid.winner).to be_nil
      expect(partial.winner).to be_nil
    end

    it 'lets you mark some more squares' do
      expect { new_grid.draw 4 }.not_to raise_error
      expect { partial.draw 5 }.not_to raise_error
    end
  end

  context "when it's a cat's game" do
    it "says it's full" do
      expect(cats).to be_full
    end

    it 'sees no winner' do
      expect(cats).not_to be_winner
      expect(cats.winner).to be_nil
    end

    it "knows it's a cat" do
      expect(cats).to be_cats
    end

    it "knows it's over" do
      expect(cats).to be_over
    end

    it 'swipes the pencil from your hand' do
      expect { cats.draw 3 }.to raise_error(StandardError)
    end
  end

  context 'when a side has won' do
    it 'spots a winner' do
      expect(x_wins).to be_winner
      expect(o_wins).to be_winner
      expect(x_wins.winner).to eq(:x)
      expect(o_wins.winner).to eq(:o)
    end

    it 'sees no cat' do
      expect(x_wins).not_to be_cats
      expect(o_wins).not_to be_cats
    end

    it "knows it's over" do
      expect(x_wins).to be_over
      expect(o_wins).to be_over
    end

    it 'makes losers put their pencils down' do
      expect { x_wins.draw 3 }.to raise_error(StandardError)
      expect { o_wins.draw 5 }.to raise_error(StandardError)
    end
  end
end

# rubocop: enable Metrics/BlockLength
