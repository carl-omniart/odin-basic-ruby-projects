# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/mastermind/board'
require_relative '../../lib/mastermind/rules'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Mastermind::Board class' do
  let(:rules) { double('rules', guesses: 12) }

  describe 'rules' do
    it 'needs them' do
      board = Mastermind::Board.new :keep_calm_and_carry_on
      expect(board.rules).to eq(:keep_calm_and_carry_on)
    end
  end

  describe 'code' do
    it 'takes a code' do
      board = Mastermind::Board.new rules
      expect { board.code = %i[my voice is my passport] }.not_to raise_error
    end

    it 'does not reveal the code' do
      board      = Mastermind::Board.new rules
      board.code = %i[e n i g m a]
      expect { board.code }.to raise_error(NoMethodError)
    end

    it 'says when it has a code' do
      board = Mastermind::Board.new rules
      expect(board.code?).to eq(false)

      board.code = %i[w h a t c o u l d i t b e ?]
      expect(board.code?).to eq(true)
    end

    it 'knows when the code has been broken' do
      board = Mastermind::Board.new rules
      board.code = %i[a la peanut butter sandwiches]
      expect(board).not_to be_broken

      board.guess(*%i[by the power of grayskull])
      expect(board).not_to be_broken

      board.guess(*%i[a la peanut butter sandwiches])
      expect(board).to be_broken
    end
  end

  describe 'guesses' do
    it 'holds guesses' do
      board      = Mastermind::Board.new rules
      board.code = %i[john paul george ringo]
      expect(board.guesses).to be_empty

      board.guess(*%i[roger pete john keith])
      expect(board.guesses.size).to eq(1)

      board.guess(*%i[henry john george charles])
      expect(board.guesses.size).to eq(2)
    end

    it 'knows when the code breaker has run out of guesses' do
      board      = Mastermind::Board.new double('rules', guesses: 3)
      board.code = %i[t m i]

      expect(board).not_to be_over

      board.guess([%(l o l)])
      expect(board).not_to be_over

      board.guess([%(w t f)])
      expect(board).not_to be_over

      board.guess([%(s m h)])
      expect(board).to be_over
    end
  end

  describe 'score' do
    xit 'gives the score when over' do
      board = Mastermind::Board.new rules
    end
  end
end

# rubocop: enable Metrics/BlockLength
