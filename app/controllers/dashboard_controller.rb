class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    @checkout_session_product1 = current_user.payment_processor.checkout(
    mode: 'subscription',
    line_items: [{
      price: 'price_1OkDtdHhcsFflMX4DLJqziDA',
      quantity: 1
    }],
    subscription_data: {
      trial_period_days: 30,
    },
  )
  end
end
