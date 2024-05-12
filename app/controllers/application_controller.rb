class ApplicationController < ActionController::Base
  before_action :authenticate_member!, except: [:top, :about, :show, :index, :timeline, :guest_sign_in]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_member_is_active, only: [:create], if: :devise_controller?

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected
  def check_member_is_active
    member = Member.find_by(account_name: params[:member][:account_name])
    return if member.nil?
    return unless member.valid_password?(params[:member][:password])
    unless member.is_active
      flash[:alert] = "your account is deactivated."
      redirect_to new_member_registration_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name, :email, :nickname, :is_private])
  end
end
