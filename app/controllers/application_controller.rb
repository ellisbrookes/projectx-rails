class ApplicationController < ActionController::Base
  before_action :set_breadcrumbs
  before_action :set_billing_portal

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pundit::Authorization
  include ApplicationHelper
  include Pagy::Backend

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
    @portal_session = Stripe::BillingPortal::Session.create({
      customer: Stripe::Customer.list(email: current_user.email).data.first.id,
      return_url: 'http://localhost:3000/dashboard',
    }) if dashboard_request && user_signed_in?
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: dashboard_index_path)
  end
end
