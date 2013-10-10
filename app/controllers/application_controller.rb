class ApplicationController < ActionController::Base

  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to settings_path, :alert => exception.message
  end

  before_filter :configure_devise_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def after_sign_up_path_for(resource)

  end

  protected

    def configure_devise_params
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:name, :password, :password_confirmation, :email)
      end
    end
end
