class NotificationsController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'

  def index
    @notifications = current_user.notifications.order(:event_id)
    add_breadcrumbs("Notifications", notifications_path)
  end

  private

  def notification_params
    params.require(:notification).permit(:message)
  end
end
