class MembersController < ApplicationController
  before_action :is_matching_login_member, except: [:index, :show]
  before_action :ensure_guest_member, only: [:edit]

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @feeds = @member.feeds.order(created_at: :desc)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "You profile has been updated successfully."
      redirect_to member_path(@member.id)
    else
      @member.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:account_id, :email, :name, :introduction, :is_private, :is_active, :profile_image)
  end

  def is_matching_login_member
    member = Member.find(params[:id])
    unless member.id == current_member.id
      redirect_to home_path
    end
  end

  def ensure_guest_member
    if current_member.email == CONST_GUEST_USER_EMAIL
      flash[:alert] = "A prohibited action by guest member. please log in or sign up"
      sign_out(current_member)
      redirect_to root_path
    end
  end

end
