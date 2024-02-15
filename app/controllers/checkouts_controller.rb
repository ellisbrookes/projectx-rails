class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: [{
        price: 'price_1OjpdvHhcsFflMX4D5Xer0oT',
        quantity: 1
      }]
    )
  end
end