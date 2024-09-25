# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/mastermind/code'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Mastermind::Code' do
  describe 'class methods' do
    before(:each) do
      @original_holes      = Mastermind::Code.holes
      @original_duplicates = Mastermind::Code.duplicates?
      @original_blanks     = Mastermind::Code.blanks?
      @original_key_pegs   = Mastermind::Code.key_pegs
    end

    after(:each) do
      Mastermind::Code.tap do |c|
        c.holes    = @original_holes
        c.key_pegs = @original_key_pegs

        @original_duplicates ? c.duplicates! : c.no_duplicates!
        @original_blanks     ? c.blanks!     : c.no_blanks!
      end
    end

    it 'has a number of holes' do
      1.upto(12).each do |holes|
        Mastermind::Code.holes = holes
        expect(Mastermind::Code.holes).to eq(holes)
      end
    end

    it 'permits or bans duplicates' do
      Mastermind::Code.no_duplicates!
      expect(Mastermind::Code.duplicates?).to eq(false)

      Mastermind::Code.duplicates!
      expect(Mastermind::Code.duplicates?).to eq(true)
    end

    it 'permits or bans blanks' do
      Mastermind::Code.no_blanks!
      expect(Mastermind::Code.blanks?).to eq(false)

      Mastermind::Code.blanks!
      expect(Mastermind::Code.blanks?).to eq(true)
    end

    it 'has an array of key pegs' do
      stoplight = %i[green yellow red]
      Mastermind::Code.key_pegs = stoplight
      expect(Mastermind::Code.key_pegs).to eq(stoplight)
    end

    context 'by default' do
      it 'has 4 holes' do
        expect(Mastermind::Code.holes).to eq(4)
      end

      it 'permits duplicates' do
        expect(Mastermind::Code.duplicates?).to eq(true)
      end

      it 'bans blanks' do
        expect(Mastermind::Code.blanks?).to eq(false)
      end

      it 'has red, white, and nil key pegs' do
        expect(Mastermind::Code.key_pegs).to eq([:red, :white, nil])
      end
    end
  end

  describe 'new' do
    it 'needs a set of pegs' do
      expect { Mastermind::Code.new(*%i[p e g s]) }.not_to raise_error
      expect { Mastermind::Code.new }.to raise_error(StandardError)
    end

    it 'checks for correct number of pegs' do
      too_few  = %i[1 2 3]
      too_many = %i[1 2 3 4 5]

      expect { Mastermind::Code.new(*too_few) }.to raise_error(StandardError)
      expect { Mastermind::Code.new(*too_many) }.to raise_error(StandardError)
    end

    context 'when rules ban duplicates' do
      before(:each) do
        @original_duplicates = Mastermind::Code.duplicates?
        Mastermind::Code.no_duplicates!
      end

      after(:each) do
        if @original_duplicates
          Mastermind::Code.duplicates!
        else
          Mastermind::Code.no_duplicates!
        end
      end

      it 'raises a fuss if it gets a duplicate' do
        [
          %i[A A c d],
          %i[a B c B],
          %i[A B B A],
          %i[a B B B],
          %i[A A A A]
        ].each do |pegs|
          expect { Mastermind::Code.new(*pegs) }.to raise_error(StandardError)
        end
      end
    end

    context 'when rules ban blanks' do
      before(:each) do
        @original_blanks = Mastermind::Code.blanks?
      end

      after(:each) do
        if @original_blanks
          Mastermind::Code.blanks!
        else
          Mastermind::Code.no_blanks!
        end
      end

      it 'raises a fuss if it gets a blank' do
        [
          [nil, :b2, :c3, :d4],
          [:a1, :b2, :c3, nil],
          [nil, nil, :c3, :d4],
          [:a1, nil, :c3, nil],
          [nil, :b2, nil, nil],
          [nil, nil, nil, nil]
        ].each do |pegs|
          expect { Mastermind::Code.new(*pegs) }.to raise_error(StandardError)
        end
      end
    end
  end

  describe 'equality' do
    it 'is equal if pegs are equal' do
      this = Mastermind::Code.new(*%i[p e g s])
      that = Mastermind::Code.new(*%i[p e g s])

      expect(this).to eq(that)
    end
  end

  describe 'compare' do
    it 'gives red for pegs with right color and right position' do
      p Mastermind::Code.duplicates?
      code = Mastermind::Code.new(*%i[c e d e])

      {
        0 => %i[b a b a],
        1 => %i[b a b e],
        2 => %i[b a d e],
        3 => %i[b e d e],
        4 => %i[c e d e]
      }.each do |count, pegs|
        other    = Mastermind::Code.new(*pegs)
        feedback = code.compare other
        expect(feedback.count(:red)).to eq(count)
      end
    end

    it 'gives white for pegs with right color and wrong position' do
      code = Mastermind::Code.new(*%i[p o s t])

      {
        0 => %i[r o u t],
        1 => %i[p r o p],
        2 => %i[s o u p],
        3 => %i[o p u s],
        4 => %i[s t o p]
      }.each do |count, pegs|
        other    = Mastermind::Code.new(*pegs)
        feedback = code.compare other
        expect(feedback.count(:white)).to eq(count)
      end
    end

    it 'gives nil for pegs with wrong color' do
      code = Mastermind::Code.new(*%i[l i n k])

      {
        0 => %i[k i l n],
        1 => %i[m i l k],
        2 => %i[m i n i],
        3 => %i[j i m i],
        4 => %i[m m m m]
      }.each do |count, pegs|
        other    = Mastermind::Code.new(*pegs)
        feedback = code.compare other
        expect(feedback.count(nil)).to eq(count)
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
