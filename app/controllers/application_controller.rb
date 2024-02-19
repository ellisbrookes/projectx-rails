class ApplicationController < ActionController::Base
  before_action :set_breadcrumbs
  before_action :set_billing_portal

  include Pagy::Backend
  include ApplicationHelper

  helper_method :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumbs(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  private

  def set_breadcrumbs
    add_breadcrumbs("Dashboard", dashboard_index_path)
  end

  def set_billing_portal
    # @portal_session = current_user&.payment_processor&.billing_portal if dashboard_request
  end
end
