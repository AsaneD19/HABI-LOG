class MembersController < ApplicationController
  before_action :is_matching_login_member, except: [:index, :show]

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
    params.require(:member).permit(:account_name, :email, :nickname, :introduction, :is_private, :is_active, :follow_count, :followed_count, :profile_image)
  end


  def is_matching_login_member
    member = Member.find(params[:id])
    unless member.id == current_member.id
      redirect_to timeline_path
    end
  end

end
