# frozen_string_literal: true

module Mastermind
  # A general Mastermind exception.
  class Error < StandardError; end

  # Raised when a value (such as the number of code pegs) is out of range.
  class RangeError < Error
    def initialize(value, range)
      message = "#{value} must be between #{range.min} and #{range.max}."
      super(message)
    end
  end

  class ArgumentError < Error; end

  class SizeError < Error
    def initialize(size, max)
      super("Size of #{size} exceeds #{max} maximum.")
    end
  end
end
