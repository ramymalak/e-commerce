json.orders @orders do |order|
  json.(order, :id, :order_no, :total,:date,:customers_id)
  json.lines order.lines do |line|
    json.(line, :id, :product_id,:qty,:unit_price,:total_price)
  end
end