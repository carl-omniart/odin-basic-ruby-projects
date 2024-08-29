# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/caesar_cipher'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Caesar Cipher Project' do
  it 'wraps lower case letters from z to a' do
    expect(caesar_cipher('xyz', 3)).to eq('abc')
    expect(caesar_cipher('abc', 25)).to eq('zab')
    expect(caesar_cipher('abc', 27)).to eq('bcd')
  end

  it 'wraps upper case letters from Z to A' do
    expect(caesar_cipher('XYZ', 3)).to eq('ABC')
    expect(caesar_cipher('ABC', 25)).to eq('ZAB')
    expect(caesar_cipher('ABC', 27)).to eq('BCD')
  end

  it 'wraps lower case letters from a to z' do
    expect(caesar_cipher('abc', -3)).to eq('xyz')
    expect(caesar_cipher('abc', -25)).to eq('bcd')
    expect(caesar_cipher('abc', -27)).to eq('zab')
  end

  it 'wraps upper case letters from A to Z' do
    expect(caesar_cipher('ABC', -3)).to eq('XYZ')
    expect(caesar_cipher('ABC', -25)).to eq('BCD')
    expect(caesar_cipher('ABC', -27)).to eq('ZAB')
  end

  it 'preserves case' do
    expect(caesar_cipher('aBcDeFgH', 2)).to eq('cDeFgHiJ')
  end

  it 'keeps its cool with non-letters' do
    expect(caesar_cipher('a,b.c!d e?f/g?', 1)).to eq('b,c.d!e f?g/h?')
  end

  it 'just works' do
    expect(caesar_cipher('What a string!', 5)).to eq('Bmfy f xywnsl!')
  end
end

# rubocop: enable Metrics/BlockLength
