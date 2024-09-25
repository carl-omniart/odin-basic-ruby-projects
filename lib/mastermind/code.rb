# frozen_string_literal: true

module Mastermind
  # Mastermind::Code ...
  class Code
    LENGTHS      = (1..64) # arbitrary maximum
    COLOR_COUNTS = (2..36) # range of base in String#to_i(base)

    @length      = 4
    @color_count = 6
    @duplicates  = true

    class << self
      attr_reader :length, :color_count

      def length=(length)
        raise(RangeError, length, LENGTHS) unless LENGTHS.covers? length

        @length = Integer length
      end

      def color_count=(count)
        raise(RangeError, count, COLOR_COUNTS) unless COLOR_COUNTS.covers? count

        @color_count = Integer count
      end

      def colors
        (0...color_count)
      end

      def duplicates?
        @duplicates
      end

      def duplicates!
        @duplicates = true
      end

      def no_duplicates!
        @duplicates = false
      end

      def new(*colors)
        %i[
          pass_length_check?
          pass_member_check?
          pass_duplicates_check?
        ].each do |check|
          raise(ArgumentError, does_not_pass(check)) unless send(check, colors)
        end

        super
      end

      private

      def pass_length_check?(colors)
        colors.size == length
      end

      def pass_member_check?(colors)
        (colors - self.colors).empty?
      end

      def pass_duplicates_check?(colors)
        duplicates? || colors.size == colors.uniq.size
      end

      def does_not_pass(check)
        pass_check = check.to_s.tr('_', ' ').delete '?'
        "Does not #{pass_check}."
      end
    end

    def initialize(*colors)
      @colors = encrypt colors
    end

    attr_reader :colors

    def ==(other)
      other.is_a?(self.class) && colors == other.colors
    end

    def difference_from(other)
      [
        (self & other),
        (self ^ other),
        (self % other)
      ]
    end

    def &(other)
      # The sorting of decrypted #colors arrays into short and long allows for
      # accurate comparison in the following edge case: when the arrays have
      # different lengths, and the longer array contains a nil at an index
      # greater than the length of the shorter array. When a longer array calls
      # zip and accepts a shorter array as argument, it pads the shorter array
      # with nils. This could result in false positives. For example, [1] & [1,
      # nil] => 2 instead of 1.

      short, long = [decrypt(colors), decrypt(other.colors)].sort_by(&:size)
      short.zip(long).count { |a, b| a == b }
    end

    alias count_of_colors_in_shared_positions &

    def |(other)
      a = decrypt colors
      b = decrypt other.colors
      (a & b).sum { |color| [a.count(color), b.count(color)].min }
    end

    alias count_of_shared_colors |

    def ^(other)
      (self | other) - (self & other)
    end

    alias count_of_shared_colors_exclusive_of_those_sharing_positions ^

    def %(other)
      # Reciprocal when equal length. When self.colors is longer than
      # other.colors, self % other will necssarily return a higher value than
      # other % self.

      a = decrypt colors
      b = decrypt other.colors
      a.uniq.sum { |color| [a.count(color) - b.count(color), 0].max }
    end

    alias count_of_colors_sharing_neither_color_nor_position %

    private

    def base
      self.class.color_count
    end

    def encrypt(ary)
      ary.map { |item| item.to_s base }.join.to_i(base)
    end

    def decrypt(int)
      int.to_s(base).each_char.map { |char| char.to_i base }
    end
  end
end
