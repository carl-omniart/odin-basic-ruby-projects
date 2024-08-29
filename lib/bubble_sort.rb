def bubble_sort array
  array = array.dup
  array.each_index.drop(1).each do |pass|
    array.each_index.take(array.size - pass).each do |i|
      small, big = array[i], array[i + 1]
      array[i], array[i + 1] = big, small if small > big
    end
  end
  array
end