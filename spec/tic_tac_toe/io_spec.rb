# frozen_string_literal: true

require 'spec_helper'
require 'stringio'
require_relative '../../lib/tic_tac_toe'

# rubocop: disable Metrics/BlockLength

RSpec.describe 'TicTacToe::IO class' do
  before(:each) do
    @original_stdout = $stdout
    @original_stdin  = $stdin
    string_io        = StringIO.new
    $stdout          = string_io
    $stdin           = string_io
  end

  after(:each) do
    $stdout          = @original_stdout
    $stdin           = @original_stdin
    @original_stdout = nil
    @original_stdin  = nil
  end

  let(:new_io) { TicTacToe::IO.new input: $stdin, output: $stdout }
  let(:control_chars) { "\a\b\e\f\r\t\v".chars }

  describe 'posting' do
    it 'posts a string with trailing newline' do
      new_io.post 'Hello!'
      expect($stdout.string).to end_with("Hello!\n")
    end

    it 'posts multiple strings' do
      new_io.post '1', '2', '3'
      expect($stdout.string.chomp).to end_with("1\n2\n3")
    end

    it 'spaces posts' do
      io = new_io
      io.post_spacing = 1
      io.post 'line'
      expect($stdout.string).to end_with("line\n\n")

      io.post_spacing = 2
      io.post 'line'
      expect($stdout.string).to end_with("line\n\n\n")
    end

    it 'posts newlines' do
      new_io.post "first\nsecond"
      expect($stdout.string.chomp).to end_with("first\nsecond")
    end

    it 'does not post other control characters' do
      new_io.post "H#{control_chars.join}i"
      expect($stdout.string.chomp).to end_with('Hi')
    end
  end

  describe 'prompting' do
    it 'prints a string with a trailing space' do
      new_io.prompt 'Name:'
      expect($stdout.string).to end_with('Name: ')
    end

    it 'does not print newlines' do
      new_io.prompt "first\nsecond"
      expect($stdout.string).to end_with('firstsecond ')
    end

    it 'does not print other control characters' do
      new_io.prompt "H#{control_chars.join}i"
      expect($stdout.string).to end_with('Hi ')
    end
  end

  describe 'requesting string' do
    it 'gets a string from the user' do
      allow($stdin).to receive(:gets).and_return('John Q. Public')
      expect(new_io.user_string).to eq('John Q. Public')
    end

    it 'filters out newlines' do
      allow($stdin).to receive(:gets).and_return("line\n")
      expect(new_io.user_string).to eq('line')
    end

    it 'filters out control characters' do
      allow($stdin).to receive(:gets).and_return("H#{control_chars.join}i")
      expect(new_io.user_string).to eq('Hi')
    end
  end

  describe 'requesting character' do
    it 'gets a character from the user' do
      allow($stdin).to receive(:getch).and_return('Y')
      expect(new_io.user_char('Y', 'N')).to eq('Y')
    end

    xit 'whitelists characters' do
      # Not sure how to test. Need to sequence :getch somehow.
    end

    it 'does not filter out newline' do
      allow($stdin).to receive(:getch).and_return("\n")
      expect(new_io.user_char("\n")).to eq("\n")
    end

    it 'does not filter out control characters' do
      control_chars.each do |char|
        allow($stdin).to receive(:getch).and_return(char)
        expect(new_io.user_char(*control_chars)).to eq(char)
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
