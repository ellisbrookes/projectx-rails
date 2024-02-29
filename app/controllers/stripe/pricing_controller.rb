module Stripe
  class PricingController < ApplicationController
    def index
      @prices = Stripe::Price.list(active: true, expand: ['data.product']).data.sort_by(&:unit_amount)
      @monthly = @prices.select { |price| price.recurring.interval == 'month' }.sort_by(&:unit_amount)
      @yearly = @prices.select { |price| price.recurring.interval == 'year' }.sort_by(&:unit_amount)
    end
  end
end
