# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

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
      flash[:alert] = "your account has been deactivated."
      redirect_to root_path
    end
  end

end
