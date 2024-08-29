# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/substrings'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Substrings Project' do
  dictionary = %w[
    below down go going horn how howdy it i low own part partner sit
  ]

  it 'returns a hash' do
    expect(substrings('word', dictionary)).to be_a Hash
  end

  it 'finds substrings in a single word' do
    expected = { 'below' => 1, 'low' => 1 }
    expect(substrings('below', dictionary)).to eq(expected)
  end

  it 'ignores case' do
    expected = { 'partner' => 1, 'part' => 1 }
    expect(substrings('PartNerS', dictionary)).to eq(expected)
  end

  it 'handles multiple words' do
    sentence = "Howdy partner, sit down! How's it going?"
    expected = {
      'down' => 1,
      'go' => 1,
      'going' => 1,
      'how' => 2,
      'howdy' => 1,
      'it' => 2,
      'i' => 3,
      'own' => 1,
      'part' => 1,
      'partner' => 1,
      'sit' => 1
    }
    expect(substrings(sentence, dictionary)).to eq(expected)
  end

  it 'correctly tallies a word with doubled substring' do
    expected = { 'it' => 2, 'i' => 2 }
    expect(substrings('nitwit', dictionary)).to eq(expected)
  end
end

# rubocop: enable Metrics/BlockLength
