def substrings string, dictionary
  tally(string.downcase, dictionary).select { |word, count| count > 0 }
end

def tally string, dictionary
  dictionary.each_with_object({}) do |sub, tally|
    tally[sub] = string.scan(sub).length
  end
end
