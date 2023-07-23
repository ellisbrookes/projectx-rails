class TeamsController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
     @teams = Team.all
  end
end