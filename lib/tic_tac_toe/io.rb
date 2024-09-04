# frozen_string_literal: true

require 'io/console'

module TicTacToe
  # TicTacToe::IO controls input/output interactions with user.
  class IO
    class << self
      def clear_control_chars(string)
        string.gsub(/\p{c}/, '')
      end
    end

    DEFAULTS = {
      input: $stdin,
      output: $stdout,
      post_spacing: 0,
      char_transform: :itself
    }.freeze

    def initialize(**opts)
      opts = DEFAULTS.merge opts

      self.input          = opts[:input]
      self.output         = opts[:output]
      self.post_spacing   = opts[:post_spacing]
      self.char_transform = opts[:char_transform]
    end

    attr_accessor :input, :output
    attr_reader :post_spacing, :char_transform

    def post_spacing=(value)
      value.send :times
      @post_spacing = value
    end

    def char_transform=(method)
      ''.send method
      @char_transform = method
    end

    def post(*lines)
      lines = lines
              .flat_map { |line| line.split("\n") }
              .map { |line| self.class.clear_control_chars line }
      output.puts lines
      space_posts
    end

    def prompt(string)
      string = self.class.clear_control_chars string
      output.print "#{string} "
    end

    def space_posts
      post_spacing.times { output.puts }
      nil
    end

    def request_string(message)
      prompt message
      user_string
    end

    def request_char(message, *valid_chars)
      prompt message
      user_char(*valid_chars)
    end

    def user_string
      string = input.gets
      space_posts
      self.class.clear_control_chars string
    end

    def user_char(*valid_chars)
      valid_chars = valid_chars.map(&char_transform).uniq
      char = input.getch.send(char_transform) until valid_chars.include?(char)
      post char
      char
    end
  end
end
