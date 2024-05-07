class MembersController < ApplicationController
    before_action :is_matching_login_member, except: [:index, :show]
    
    
    
    
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
