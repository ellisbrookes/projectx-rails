class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    session = Stripe::Checkout::Session.create(
      success_url: 'https://example.com/success.html?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'https://example.com/canceled.html',
      mode: 'payment',
      line_items: [{
        price: 'price_1OjpdvHhcsFflMX4D5Xer0oT',
        quantity: '1'
      }]
    )
  end
end