class ApplicationController < ActionController::Base
  before_action :set_breadcrumbs
  before_action :set_billing_portal

  include ApplicationHelper
  include Pagy::Backend

  helper_method :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumbs(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.dashboard_index_url, alert: exception.message
  end

  private

  def set_breadcrumbs
    add_breadcrumbs("Dashboard", dashboard_index_path)
  end

  def set_billing_portal
    @portal_session = Stripe::BillingPortal::Session.create({
      customer: Stripe::Customer.list(email: current_user.email).data.first.id,
      return_url: 'http://localhost:3000/dashboard',
    }) if dashboard_request && user_signed_in?
  end
end
