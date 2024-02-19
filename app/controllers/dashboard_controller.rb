class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    flash[:notice] = "You have 2 days left on your free trial. Please upgrade now to keep your account"
  end
end
