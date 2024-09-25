# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/mastermind/game'
require_relative '../../lib/mastermind/player'

RSpec.describe 'Mastermind::Game class' do
  it 'has two players' do
    players = %i[alekhine nimzowitsch]
    game    = Mastermind::Game.new(*players)
    expect(game.players).to eq(players)
  end

  it 'assigns one player to be code maker' do
    players = %i[karpov kasparov]
    game    = Mastermind::Game.new(*players)
    expect(game.code_maker).to eq(:karpov)
  end

  it 'assigns the other player to be code breaker' do
    players = %i[carlsen anand]
    game    = Mastermind::Game.new(*players)
    expect(game.code_breaker).to eq(:anand)
  end

  it 'has a board' do
    game = Mastermind::Game.new :capablanca, :lasker
    expect(game.board).to be_a(Mastermind::Board)
  end

  it 'sets the code' do
    players = Array.new(2) { Mastermind::Player.new }
    game = Mastermind::Game.new(*players)
    game.make_code!

    expect(game.board.code?).to eq(true)
  end
end
