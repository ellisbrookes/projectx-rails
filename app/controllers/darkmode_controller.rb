class DarkmodeController < ApplicationController
  def update_dark_mode_preference
    # Update the session variable or other storage mechanism based on the preference
    session[:dark_mode] = params[:dark_mode]
    
    # Respond with JSON indicating the updated dark mode status
    render json: { dark_mode: session[:dark_mode] }
  end
end