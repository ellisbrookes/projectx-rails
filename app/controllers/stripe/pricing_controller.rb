class Stripe::PricingController < ApplicationController
  def index
    @prices = Stripe::Price.list(active: true, expand: ['data.product']).data.sort_by(&:unit_amount)
  end
end
