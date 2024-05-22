class FollowRequestsController < ApplicationController

  def create
    current_member.follow_request(params[:member_id])
    redirect_to member_path(params[:member_id])
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to member_path(params[:member_id])
  end

end
