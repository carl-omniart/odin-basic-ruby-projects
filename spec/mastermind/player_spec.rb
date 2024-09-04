# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/mastermind/player'
require_relative '../../lib/mastermind/rules'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Mastermind::Player class' do
  xit 'takes a name' do
    player      = Mastermind::Player.new
    player.name = 'Simon'
    expect(player.name).to eq('Simon')

    player = Mastermind::Player.new name: 'Garfunkel'
    expect(player.name).to eq('Garfunkel')
  end

  context 'as Code Maker' do
    xit 'sets a combination of code pegs' do
      spice_girls = %i[baby ginger posh scary sporty]
      rules       = Mastermind::Rules.new code_pegs: spice_girls
      code        = Mastermind::Player.new.make_code rules

      expect(code - spice_girls).to be_empty
    end

    xit 'sets as many pegs as rules require' do
      0.upto(13) do |n|
        rules = Mastermind::Rules.new holes: n
        code  = Mastermind::Player.new.make_code rules

        expect(code.size).to eq(n)
      end
    end

    xit 'sets codes with blanks' do
      player = Mastermind::Player.new
      rules  = Mastermind::Rules.new blanks: true
      codes  = Array.new(10) { player.make_code rules }

      expect(codes.any? { |code| code.include? nil }).to be_true
    end

    xit 'sets codes without blanks' do
      player = Mastermind::Player.new
      rules  = Mastermind::Rules.new blanks: false
      codes  = Array.new(10) { player.make_code rules }

      expect(codes.any? { |code| code.include? nil }).to be_false
    end

    xit 'sets codes with duplicates' do
      player  = Mastermind::Player.new
      quintet = %i[herbie miles ron tony wayne]
      rules   = Mastermind::Rules.new code_pegs: quintet,
                                      holes: 5,
                                      duplicates: false
      codes   = Array.new(10) { player.make_code rules }

      expect(codes.all? { |code| code.size == code.uniq.size }).to be_true
    end

    xit 'sets codes without duplicates' do
      player  = Mastermind::Player.new
      quintet = %i[daphne fred scooby shaggy velma]
      rules   = Mastermind::Rules.new code_pegs: quintet,
                                      holes: 5,
                                      duplicates: true
      codes   = Array.new(10) { player.make_code rules }

      expect(codes.all? { |code| code.size == code.uniq.size }).to be_false
    end
  end

  context 'as Code Breaker' do
    xit 'guesses a combination of code pegs' do
      x_men   = %i[angel beast cyclops jean_grey iceman]
      rules   = Mastermind::Rules.new code_pegs: x_men
      guesses = []
      code    = Mastermind::Player.new.break_code rules, guesses

      expect(code - x_men).to be_empty
    end

    xit 'guesses as many pegs as rules require' do
      0.upto(13) do |n|
        rules   = Mastermind::Rules.new holes: n
        guesses = []
        code    = Mastermind::Player.new.break_code rules, guesses

        expect(code.size).to eq(n)
      end
    end

    xit 'guesses codes with blanks' do
      player  = Mastermind::Player.new
      rules   = Mastermind::Rules.new blanks: true
      guesses = []
      codes   = Array.new(10) { player.break_code rules, guesses }

      expect(codes.any? { |code| code.include? nil }).to be_true
    end

    xit 'guesses codes without blanks' do
      player  = Mastermind::Player.new
      rules   = Mastermind::Rules.new blanks: false
      guesses = []
      codes   = Array.new(10) { player.break_code rules, guesses }

      expect(codes.any? { |code| code.include? nil }).to be_false
    end

    xit 'guesses codes with duplicates' do
      player  = Mastermind::Player.new
      septet  = %i[envy gluttony greed lust pride sloth wrath]
      rules   = Mastermind::Rules.new code_pegs: septet,
                                      holes: 7,
                                      duplicates: true
      guesses = []
      codes   = Array.new(10) { player.make_code rules, guesses }

      expect(codes.all? { |code| code.uniq.size == code.size }).to be_false
    end

    xit 'guesses codes without duplicates' do
      player  = Mastermind::Player.new
      septet  = %i[cynthia freddie greg jerry larry rose sly]
      rules   = Mastermind::Rules.new code_pegs: septet,
                                      holes: 7,
                                      duplicates: false
      guesses = []
      codes   = Array.new(10) { player.make_code rules, guesses }

      expect(codes.all? { |code| code.uniq.size == code.size }).to be_true
    end
  end
end

# rubocop: enable Metrics/BlockLength
