def stock_picker(prices)
  best_day = nil
  max_profit = 0

  prices.each_with_index do |buy_price, buy_day|
    prices.each_with_index do |sell_price, sell_day|
      if sell_day > buy_day
        profit = sell_price - buy_price
        if profit > max_profit
          max_profit = profit
          best_day = [buy_day, sell_day]
        end
      end
      end
    end
  best_day
end

puts stock_picker([17,3,6,9,15,8,6,1,])