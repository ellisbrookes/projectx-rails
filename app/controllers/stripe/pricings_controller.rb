class Stripe::PricingsController < ApplicationController
  def index
    @prices = Stripe::Price.list(active: true)
  end
end
