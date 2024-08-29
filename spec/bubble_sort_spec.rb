require 'spec_helper.rb'
require_relative '../lib/bubble_sort.rb'

RSpec.describe 'Bubble Sort Project' do
  it 'sorts!' do
    expect(bubble_sort([4, 3, 78, 2, 0, 2])).to eq([0, 2, 2, 3, 4, 78])
    expect(bubble_sort([87, 26, 74, 33, 9, 52])).to eq([9, 26, 33, 52, 74, 87])
    expect(bubble_sort([11, 13, 11, 13, 6, 13])).to eq([6, 11, 11, 13, 13, 13])
  end
end