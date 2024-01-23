class ApplicationController < ActionController::Base
  before_action :set_breadcrumbs
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
    add_breadcrumbs("Dashbaord", dashboard_index_path)
  end
end
