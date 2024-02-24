class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    flash[:notice] = if !current_user.subscription_expired?
      "Your free trial has expired. Please upgrade now to keep your account."
    else
      "You have #{current_user.days_until_subscription_expiration} days left on your free trial. Please upgrade now to keep your account."
    end
  end
end
