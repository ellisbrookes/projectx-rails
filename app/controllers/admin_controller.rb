class AdminController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'

  def index
    @total_users = User.count
    authorize(:super_admin)
  end
end
