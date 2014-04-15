class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  
  def total_price
    self.product.price * self.quantity
  end
end
