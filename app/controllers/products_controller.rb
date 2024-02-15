class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[index]

  def index
    @products = Product.all
    @checkout_session_product1 = current_user.payment_processor.checkout(
      mode: 'subscription',
      line_items: [{
        price: 'price_1OjpdvHhcsFflMX4D5Xer0oT',
        quantity: 1
      }]
      subcription_data: {
        trial_period_days: 30,
      },
    )
    @checkout_session_product2 = current_user.payment_processor.checkout(
    mode: 'subscription',
    line_items: [{
      price: 'price_1Ok8o8HhcsFflMX4yvHHKvc7',
      quantity: 1
    }]
    subcription_data: {
      trial_period_days: 30,
    },
  )
  @checkout_session_product3 = current_user.payment_processor.checkout(
    mode: 'subscription',
    line_items: [{
      price: 'price_1Ok8raHhcsFflMX4SjlQ5pn9',
      quantity: 1
    }]
    subcription_data: {
      trial_period_days: 30,
    },
  )
  end

  private

  def set_product
    @product = Product.find_by(params[:id])
  end

  def product_params
    params.require(:product).permit(:id, :name, :description, :price)
  end
end