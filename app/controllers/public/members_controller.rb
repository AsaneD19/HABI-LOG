class Public::MembersController < ApplicationController
  include CheckMember
  before_action :is_guest_member?, except: [:index, :show]

  def index
    @members = Member.all
  end

  def show
    if current_member.email == CONST_GUEST_USER_EMAIL
      guest_logout
    else
      @member = current_member
    end
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      flash[:notice] = "You profile has been updated successfully."
      redirect_to member_path(@member.id)
    else
      @member.errors.full_messages.join(", ")
      render :edit
    end
  end

  def confirm

  end

  def withdraw
    current_member.update(is_active: false)
    flash[:notice] = "退会しました."
    sign_out(current_member)
    redirect_to root_path
  end

  private

  def member_params
    params.require(:member).permit(:account_id, :email, :name, :introduction, :is_private, :is_active, :profile_image)
  end

end
