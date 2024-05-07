class ApplicationController < ActionController::Base
  before_action :authenticate_member!, except: [:top, :about, :show, :index, :timeline, :guest_sign_in]
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    timeline_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name, :email, :nickname])
  end
end
