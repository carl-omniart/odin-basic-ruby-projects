# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/mastermind/board'
require_relative '../../lib/mastermind/rules'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Mastermind::Board class' do
  xit 'takes rules' do
    board       = Mastermind::Board.new
    board.rules = :keep_calm_and_carry_on
    expect(board.rules).to eq(:keep_calm_and_carry_on)

    board = Mastermind::Board.new rules: :trust_no_one
    expect(board.rules).to eq(:trust_no_one)
  end

  xit 'takes a code' do
    board = Mastermind::Board.new
    expect { board.code = %i[my voice is my passport] }.not_to raise_error
  end

  xit 'does not reveal the code' do
    board      = Mastermind::Board.new
    board.code = %i[e n i g m a]

    expect { board.code }.to raise_error(NoMethodError)
  end

  xit 'holds guesses' do
    board      = Mastermind::Board.new
    board.code = %i[john paul george ringo]
    expect(board.guesses).to be_empty

    board.guess(*%i[roger pete john keith])
    expect(board.guesses.size).to eq(1)

    board.guess(*%i[henry john george charles])
    expect(board.guesses.size).to eq(2)
  end

  xit 'knows when the code has been broken' do
    board = Mastermind::Board.new
    board.code = %i[a la peanut butter sandwiches]
    expect(board).not_to be_broken

    board.guess(*%i[by the power of grayskull])
    expect(board).not_to be_broken

    board.guess(*%i[a la peanut butter sandwiches])
    expect(board).to be_broken
  end

  xit 'knows when the code breaker has run out of guesses' do
    board               = Mastermind::Board.new
    board.rules.guesses = 3
    board.code          = %i[t m i]

    expect(board).not_to be_over

    board.guess([%(l o l)])
    expect(board).not_to be_over

    board.guess([%(w t f)])
    expect(board).not_to be_over

    board.guess([%(s m h)])
    expect(board).to be_over
  end

  context 'by default' do
    xit 'uses default rules' do
      board = Mastermind::Board.new
      rules = Mastermind::Rules.new

      expect(board.rules.code_pegs).to match_array(rules.code_pegs)
      expect(board.rules.holes).to eq(rules.holes)
      expect(board.rules.duplicates?).to eq(rules.duplicates?)
      expect(board.rules.blanks?).to eq(rules.blanks?)
      expect(board.rules.guesses).to eq(rules.guesses)
    end
  end
end

# rubocop: enable Metrics/BlockLength
