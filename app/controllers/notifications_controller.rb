class NotificationsController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'

  def index
    @notifications = current_user.notifications.unread.order(:event_id)
    @pagy, @notifications = pagy(@notifications, items: 5)
    add_breadcrumbs("Notifications", notifications_path)
  end

  def mark_as_read
    current_user.notifications.mark_as_read
    redirect_to(notifications_path, notice: "All notifications marked as read")
  end

  def mark_as_unread
    current_user.notifications.mark_as_unread
    redirect_to(notifications_path, notice: "All notifications marked as unread")
  end

  private

  def notification_params
    params.require(:notification).permit(:message)
  end
end
