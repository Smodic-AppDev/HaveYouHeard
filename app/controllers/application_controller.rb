# frozen_string_literal: true

class ApplicationController < ActionController::Base


  before_action :authenticate_user!

  include Pundit
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized 

  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private, :first_name, :last_name])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    
    redirect_back(fallback_location: root_url)
  end

end
