module ApplicationHelper
  include Pagy::Frontend

  def dashboard_request
    request.path.start_with?("/dashboard")
  end
end
