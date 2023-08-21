module ApplicationHelper
  def dark_mode_enabled?
    session[:dark_mode] || false
  end
end
