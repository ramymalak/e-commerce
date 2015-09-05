json.order @order
json.lines @order.lines do |line|
  json.(line, :id, :product_id,:qty,:unit_price,:total_price)
end