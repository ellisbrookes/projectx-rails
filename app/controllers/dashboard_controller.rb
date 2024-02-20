class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  grant_access

  def index
    if !current_user.subscription_expired?
      flash[:notice] = "You have #{current_user.days_until_subscription_expiration} days left on your free trial. Please upgrade now to keep your account."
    else
      flash[:notice] = "Your free trial has expired. Please upgrade now to keep your account."
    end
  end
end
