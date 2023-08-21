class DarkmodeController < ApplicationController
  def update_dark_mode_preference
    session[:dark_mode] = params[:dark_mode]
    
    render json: { dark_mode: session[:dark_mode] }
  end
end