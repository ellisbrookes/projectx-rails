class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  private

  def notification_params
    params.require(:notification).permit(:content)
  end
end
