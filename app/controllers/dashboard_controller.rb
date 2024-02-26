class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    flash[:notice] = if !current_user.subscription_expired?
      "You have #{current_user.days_until_subscription_expiration} days left on your free trial. Please #{view_context.link_to("upgrade now", pricing_path)}."
    else
      "Your trial has expired. Please #{view_context.link_to("upgrade now", pricing_path)}."
    end
  end
end
