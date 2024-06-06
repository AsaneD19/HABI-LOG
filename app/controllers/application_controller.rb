class ApplicationController < ActionController::Base
  include CheckMemberStatus
  before_action :configure_authentication

  private

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
    controller_name == "homes" && (action_name == "top" || "about")
  end

end
