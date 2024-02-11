module Products
  class StripeCheckoutsController < ApplicationController
    def create
      @product = Product.find(params[:product_id])
      session = Stripe::Checkout::Session.create({
        ui_mode: 'embedded',
        line_items: [{
          quantity: 1,
          unit_amount: @product.price * 100
        }],
        mode: 'payment',
        return_url: success_product_purchases_path(@product)
      })

      render json: { clientSecret: session.client_secret }
    end
  end
end
