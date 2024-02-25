class Stripe::PricingController < ApplicationController
  def pricing
    @prices = Stripe::Price.list(active: true)
  end
end
