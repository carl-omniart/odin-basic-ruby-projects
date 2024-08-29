# frozen_string_literal: true

def substrings(string, dictionary)
  tally(string.downcase, dictionary).select { |_word, count| count.positive? }
end

def tally(string, dictionary)
  dictionary.each_with_object({}) do |sub, tally|
    tally[sub] = string.scan(sub).length
  end
end
