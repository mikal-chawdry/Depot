order_hashes = @product.orders.each do |order|
 {
	name: order.name,
  product: @product,
  quantity: order,
	address: order.address,
  pay_type: order.pay_type
}
end

order_hashes.to_json