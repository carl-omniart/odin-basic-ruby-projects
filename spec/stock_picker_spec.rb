# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/stock_picker'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'Stock Picker Project' do
  it 'returns an array' do
    expect(stock_picker([1, 2, 3, 4])).to be_an(Array)
  end

  context 'when lowest day comes first' do
    prices = [1, 5, 8, 9, 3, 2, 7, 4, 6]
    buy_day, sell_day = stock_picker prices

    it 'picks the best day to buy' do
      expect(prices.at(buy_day)).to eq(1)
    end

    it 'picks the best day to sell' do
      expect(prices.at(sell_day)).to eq(9)
    end
  end

  context 'when highest day comes first' do
    prices = [9, 6, 3, 1, 5, 7, 8, 4, 2]
    buy_day, sell_day = stock_picker prices

    it 'picks the best day to buy' do
      expect(prices.at(buy_day)).to eq(1)
    end

    it 'picks the best day to sell' do
      expect(prices.at(sell_day)).to eq(8)
    end
  end

  context 'when lowest day comes before highest day' do
    prices = [7, 2, 1, 6, 3, 8, 9, 5, 4]
    buy_day, sell_day = stock_picker prices

    it 'picks the best day to buy' do
      expect(prices.at(buy_day)).to eq(1)
    end

    it 'picks the best day to sell' do
      expect(prices.at(sell_day)).to eq(9)
    end
  end

  context 'when lowest day comes after highest day' do
    prices = [7, 2, 5, 9, 6, 8, 1, 3, 4]
    buy_day, sell_day = stock_picker prices

    it 'picks the best day to buy' do
      expect(prices.at(buy_day)).to eq(2)
    end

    it 'picks the best day to sell' do
      expect(prices.at(sell_day)).to eq(9)
    end
  end

  context 'when lowest day comes last' do
    prices = [7, 6, 9, 2, 3, 5, 8, 4, 1]
    buy_day, sell_day = stock_picker prices

    it 'picks the best day to buy' do
      expect(prices.at(buy_day)).to eq(2)
    end

    it 'picks the best day to sell' do
      expect(prices.at(sell_day)).to eq(8)
    end
  end

  context 'when highest day comes last' do
    prices = [4, 5, 3, 1, 8, 7, 2, 6, 9]
    buy_day, sell_day = stock_picker prices

    it 'picks the best day to buy' do
      expect(prices.at(buy_day)).to eq(1)
    end

    it 'picks the best day to sell' do
      expect(prices.at(sell_day)).to eq(9)
    end
  end
end

# rubocop: enable Metrics/BlockLength
