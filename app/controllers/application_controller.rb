class ApplicationController < ActionController::Base
  before_action :authenticate_member!, except: [:top, :about, :show, :index, :guest_sign_in], unless: :admin_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_member_is_active, only: [:create], if: :devise_controller?, unless: :admin_controller?

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected
  def check_member_is_active
    member = Member.find_by(account_id: params[:member][:account_id])
    return if member.nil?
    return unless member.valid_password?(params[:member][:password])
    unless member.is_active
      flash[:alert] = "your account is deactivated."
      redirect_to new_member_registration_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_id, :email, :name, :is_private])
  end

  private
  def admin_controller?
    self.class.module_parent_name == "Admin"
  end
end
