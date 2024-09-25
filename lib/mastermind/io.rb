# frozen_string_literal: true

module Mastermind
  class IO
    DEFAULTS = {
      input: $stdin,
      output: $stdout,
      post_spacing: 0,
      char_transform: :itself
    }.freeze

    class << self
      def clear_control_chars(string)
        string.gsub(/\p{c}/, '')
      end
    end

    def initialize(**opts)
      opts = DEFAULTS.merge opts

      self.input          = opts[:input]
      self.output         = opts[:output]
      self.post_spacing   = opts[:post_spacing]
      self.char_transform = opts[:char_transform]
    end

    attr_accessor :input, :output, :post_spacing, :char_transform

    def post(*lines)
      lines = lines
              .flat_map { |line| line.split("\n") }
              .map { |line| self.class.clear_control_chars line }
      output.puts lines
      space_posts
    end

    def space_posts
      post_spacing.times { output.puts }
      nil
    end

    def prompt(string)
      string = self.class.clear_control_chars string
      output.print "#{string} "
    end

    def request_string(message)
      prompt message
      user_string
    end

    def request_char(message, *valid_chars)
      prompt message
      user_char(*valid_chars)
    end

    def request_chars(message, count, *valid_chars)
      prompt message
      user_chars(count, *valid_chars)
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

    def user_chars(count, *valid_chars)
      chars       = []
      valid_chars = valid_chars.map(&char_transform).uniq << "\b"

      until chars.size == count
        print "\r#{' ' * count}\r#{chars.join}"
        char = input.getch.send(char_transform) until valid_chars.include?(char)
        char == "\b" ? chars.pop : chars << char
      end

      chars
    end
  end
end
