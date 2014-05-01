class OrderNotifier < ActionMailer::Base
  default from: "Mikal Chawdry <mikalchawdry@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order
    mail to: 'mikal.chawdry@yahoo.com', subject: "Pragmatic Store Order Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: 'mikal.chawdry@yahoo.com', subject: "Pragmatic Store Order Shipped"
  end
end
