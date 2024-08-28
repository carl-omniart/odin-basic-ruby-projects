def stock_picker prices
  buys = prices.take(prices.size - 1)

  buys.each_index.reduce([0, 1]) do |days, buy|
    sells = prices.drop buy
    sell  = buy + sells.each_index.max_by { |i| sells[i] }
    profit(prices, buy, sell) > profit(prices, *days) ? [buy, sell] : days
  end  
end

def profit prices, buy, sell
  prices[sell] - prices[buy]
end
