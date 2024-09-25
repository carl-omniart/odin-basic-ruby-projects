# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/mastermind/rules'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Mastermind::Rules class' do
  it 'takes a set of code pegs' do
    trumpets = %i[louis dizzy miles clifford lee freddie]
    saxes    = %i[lester bird sonny coltrane cannonball wayne]

    rules = Mastermind::Rules.new

    rules.code_pegs = trumpets
    expect(rules.code_pegs).to match_array(trumpets)

    rules = Mastermind::Rules.new code_pegs: saxes
    expect(rules.code_pegs).to match_array(saxes)
  end

  it 'takes a number of holes' do
    rules = Mastermind::Rules.new

    rules.holes = 13
    expect(rules.holes).to eq(13)

    rules = Mastermind::Rules.new holes: 42
    expect(rules.holes).to eq(42)
  end

  it 'permits or rejects duplicates' do
    rules = Mastermind::Rules.new

    rules.no_duplicates!
    expect(rules.duplicates?).to eq(false)

    rules.duplicates!
    expect(rules.duplicates?).to eq(true)

    rules = Mastermind::Rules.new duplicates: true
    expect(rules.duplicates?).to eq(true)

    rules = Mastermind::Rules.new duplicates: false
    expect(rules.duplicates?).to eq(false)
  end

  it 'permits or rejects blanks' do
    rules = Mastermind::Rules.new

    rules.blanks!
    expect(rules.blanks?).to eq(true)

    rules.no_blanks!
    expect(rules.blanks?).to eq(false)

    rules = Mastermind::Rules.new blanks: true
    expect(rules.blanks?).to eq(true)

    rules = Mastermind::Rules.new blanks: false
    expect(rules.blanks?).to eq(false)
  end

  it 'it takes a number of guesses' do
    rules = Mastermind::Rules.new

    rules.guesses = 7
    expect(rules.guesses).to eq(7)

    rules = Mastermind::Rules.new guesses: 11
    expect(rules.guesses).to eq(11)
  end

  context 'by default' do
    it 'has six colors for code pegs' do
      colors = %i[red orange yellow green blue purple]
      expect(Mastermind::Rules.new.code_pegs).to match_array(colors)
    end
    it 'has four holes' do
      expect(Mastermind::Rules.new.holes).to eq(4)
    end

    it 'accepts duplicates' do
      expect(Mastermind::Rules.new.duplicates?).to eq(true)
    end

    it 'rejects blanks' do
      expect(Mastermind::Rules.new.blanks?).to eq(false)
    end

    it 'has 12 guesses' do
      expect(Mastermind::Rules.new.guesses).to eq(12)
    end
  end
end

# rubocop: enable Metrics/BlockLength
