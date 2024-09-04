# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/mastermind/guess'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Mastermind::Guess class' do
  xit 'takes a set of code pegs' do
    tribe = %i[ali jarobi phife q_tip]
    guess = Mastermind::Guess.new(*tribe)

    expect(guess.code_pegs).to eq(tribe)
  end

  describe 'feedback' do
    xit 'has default key pegs of :red, :white, and nil' do
      guess = Mastermind::Guess.new(*%i[not important now])
      expect(guess.key_pegs).to eq([:red, :white, nil])
    end

    xit 'gives nil when pegs have wrong color' do
      code = %i[a b b a]
      pegs = %i[d e e d]
      guess = Mastermind::Guess.new(*pegs)
      guess.compare! code

      expect(guess.feedback).to eq([nil, nil, nil, nil])
    end

    xit 'gives a white peg for each peg with right color and wrong position' do
      code = %i[c a f e]
      pegs = %i[b e e f]
      guess = Mastermind::Guess.new(*pegs)
      guess.compare! code

      expect(guess.feedback).to match_array([:white, :white, nil, nil])

      code = %i[e d d a]
      pegs = %i[d e a d]
      guess = Mastermind::Guess.new(*pegs)
      guess.compare! code

      expect(guess.feedback).to match_array(%i[white white white white])
    end

    xit 'gives a red peg for each peg with right color and right position' do
      code = %i[b a b e]
      pegs = %i[b e d e]
      guess = Mastermind::Guess.new(*pegs)
      guess.compare! code

      expect(guess.feedback).to match_array([:red, :red, nil, nil])

      code = %i[f a c e]
      pegs = %i[f a d e]
      guess = Mastermind::Guess.new(*pegs)
      guess.compare! code

      expect(guess.feedback).to match_array([:red, :red, :red, nil])
    end

    xit 'gives a combination of red and white pegs when... you get the idea' do
      code = %i[f a c e]
      pegs = %i[c a f e]
      guess = Mastermind::Guess.new(*pegs)
      guess.compare! code

      expect(guess.feedback).to match_array(%i[red red white white])

      code = %i[a c e d]
      pegs = %i[b e a d]
      guess = Mastermind::Guess.new(*pegs)
      guess.compare! code

      expect(guess.feedback).to match_array([:red, :white, :white, nil])
    end

    xit 'can use custom key pegs' do
      stoplight = %i[green yellow red]
      code      = %i[l i o n]
      guess     = Mastermind::Guess.new(*%i[l i m o], key_pegs: stoplight)
      guess.compare! code

      expect(guess.feedback).to match_array(%i[green green yellow red])
    end
  end
end

# rubocop: enable Metrics/BlockLength
