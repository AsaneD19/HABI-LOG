class FollowRequestsController < ApplicationController

  def create
    current_member.create_follow_request(params[:member_id])
    redirect_to member_path(params[:member_id])
  end

  def update
    member = Member.find(params[:member_id])
    member.follow(current_member.id)
    byebug
    follow_request = FollowRequest.where(follower_id: member.id, followed_id: current_member.id)
    follow_request.update(is_approval: true)
    redirect_to member_path(member)
  end

  def destroy
      member = Member.find(params[:member_id])
      member.destroy_follow_request(current_member.id)
      redirect_to home_path
  end
end
