class TeamsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  layout 'dashboard'

  def index
  end
end