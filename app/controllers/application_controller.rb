class ApplicationController < ActionController::Base
  include CheckMemberStatus
  before_action :configure_authentication

  protected

  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_member! unless action_is_public?
      check_activation unless current_member == nil
    end
  end

  def admin_controller?
    self.class.module_parent_name == "Admin"
  end

  def action_is_public?
    controller_name == "homes" || "registrations"
  end

  def authenticate_member!
    unless member_signed_in? || action_is_public?
      flash[:alert] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end
end
