class TeamsController < ApplicationControlle
  before_action authenticate_user!
  layout 'dashboard'

  def index
  end
end