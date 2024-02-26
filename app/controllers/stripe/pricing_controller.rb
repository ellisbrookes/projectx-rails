class Stripe::PricingController < ApplicationController
  def index
    @prices = Stripe::Price.list(active: true, expand: ['data.product']).data.sort_by(&:unit_amount)
    @monthly = @prices.select { |price| price.recurring.interval == 'month' }
    @yearly = @prices.select { |price| price.recurring.interval == 'year' }
  end
end
