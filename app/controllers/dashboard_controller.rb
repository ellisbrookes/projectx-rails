class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    flash[:notice] = "You have 2 days left on your free trial. Please upgrade now to keep your account"
    @session = current_user.payment_processor.checkout(
      mode: 'subscription',
      line_items: [{
        price: 'price_1OkDtdHhcsFflMX4DLJqziDA',
        quantity: 1
      }],
      subscription_data: {
        trial_period_days: 30
      }
    )
    # @subscription = current_user.subscription
    # @checkout_session_product1 = current_user.payment_processor.subscribe(name: "Basic", plan: "price_1OkDtdHhcsFflMX4DLJqziDA")
  end
end
