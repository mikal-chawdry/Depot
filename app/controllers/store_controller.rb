class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  
  def index
    @products = Product.order(:title)
    logger.debug("@cart gets set by the :set_cart before_action. The value of @cart is: #{@cart.inspect}")
  end
end
