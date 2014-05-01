require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
  
    get "/"
    assert_response :success
    assert_template "index"
  
    # xml_http_request method below actually invokes the ajax request right here
    xml_http_request :post, '/line_items', product_id: ruby_book.id 
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
  
    get "/orders/new"
    assert_response :success
    assert_template "new"
  
    # the post_via_redirect method below makes a post request to /orders. This will invoke the create action in the orders controller. We have to specify the params hash.
    post_via_redirect "/orders",
                    order: { name: "Mikal Chawdry",
                             address: "123 The Street",
                             email: "mikal@email.com",
                             pay_type: "Check" }
                             
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
  
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
  
    assert_equal "Mikal Chawdry", order.name 
    assert_equal "123 The Street", order.address 
    assert_equal "mikal@email.com", order.email 
    assert_equal "Check", order.pay_type
  
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
  
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["mikal.chawdry@yahoo.com"], mail.to
    assert_equal ["Mikal Chawdry <mikalchawdry@gmail.com>"], mail.from
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end  
end
