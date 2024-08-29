# frozen_string_literal: true

def caesar_cipher(string, offset)
  string.each_char.reduce('') do |encoded, char|
    ord = char.ord
    ord = shift ord, offset, (('a'.ord)..('z'.ord))
    ord = shift ord, offset, (('A'.ord)..('Z'.ord))
    encoded << ord.chr
  end
end

def shift(value, offset, range)
  if range.cover? value
    value += offset
    value += range.size while value < range.min
    value -= range.size while value > range.max
  end
  value
end
