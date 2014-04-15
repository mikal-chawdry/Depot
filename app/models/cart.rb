class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  def add_product(product_id)
    current_item = self.line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = LineItem.new(product_id: product_id, cart: self)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end  
  
  # check below for some other ways to do the total_price method
  
  # def total_price  
#     price_array = []
#     self.line_items.each do |item|
#       price_array << item.total_price
#     end
#     price_array.inject {|sum, price| sum + price}
#   end
#   
#   def total_price
#     total = 0
#     self.line_items.each do |item|
#       total += item.total_price
#     end
#     total
#   end
      
end
