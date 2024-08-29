# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/tic_tac_toe'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'TicTacToe::Square class' do
  let(:new_square) { TicTacToe::Square.new }
  let(:x_square) { TicTacToe::Square.new.set 'X' }
  let(:o_square) { TicTacToe::Square.new.set 'O' }

  describe '.new' do
    it 'return and instance of TicTacToe::Square' do
      expect(new_square).to be_a(TicTacToe::Square)
    end
  end

  describe '.set' do
    context 'when new' do
      it 'can be set to "X"' do
        expect(new_square.set('X').to_s).to eq('X')
      end

      it 'can be set to "O"' do
        expect(new_square.set('O').to_s).to eq('O')
      end

      it 'can be set with lowercase equivalents' do
        expect(new_square.set('x').to_s).to eq('X')
        expect(new_square.set('o').to_s).to eq('O')
      end

      xit 'raises an error if set to anything else' do
        expect { new_square.set('a') }.to raise_error(TypeError)
        expect { new_square.set(0) }.to raise_error(TypeError)
        expect { new_square.set(nil) }.to raise_error(TypeError)
      end
    end

    context 'when set' do
      xit 'raises an error' do
        expect { x_square.set('O') }.to raise_error(StandardError)
        expect { o_square.set('O') }.to raise_error(StandardError)
      end
    end
  end

  describe '.to_s' do
    context 'when new' do
      it 'returns a nil string' do
        expect(new_square.to_s).to eq('')
      end
    end

    context 'when set' do
      it 'returns either "X" or "O"' do
        expect(x_square.to_s).to eq('X')
        expect(o_square.to_s).to eq('O')
      end
    end
  end

  describe '.empty?' do
    context 'when new' do
      it 'returns true' do
        expect(new_square).to be_empty
      end
    end

    context 'when set' do
      it 'returns false' do
        expect(x_square.empty?).to be(false)
        expect(o_square.empty?).to be(false)
      end
    end
  end

  describe '.x?' do
    context 'when new or set to "O"' do
      it 'returns false' do
        expect(new_square.x?).to be(false)
        expect(o_square.x?).to be(false)
      end
    end

    context 'when set to "X"' do
      it 'returns true' do
        expect(x_square.x?).to be(true)
      end
    end
  end

  describe '.o?' do
    context 'when new or set to "X"' do
      it 'returns false' do
        expect(new_square.o?).to be(false)
        expect(x_square.o?).to be(false)
      end
    end

    context 'when set to "O"' do
      it 'returns true' do
        expect(o_square.o?).to be(true)
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
