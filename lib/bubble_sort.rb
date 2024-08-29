# frozen_string_literal: true

def bubble_sort(array)
  array = array.dup

  1.upto(array.size - 1) do |last|
    front, back = split array, array.size - last + 1
    array = bubble_pass(front) + back
  end
  array
end

def split(array, index)
  [array[0, index], array[index..]]
end

def bubble_pass(array)
  array.each_index.each_cons(2) do |i, j|
    array[i], array[j] = sort_two array[i], array[j]
  end
  array
end

def sort_two(one, two)
  one < two ? [one, two] : [two, one]
end
