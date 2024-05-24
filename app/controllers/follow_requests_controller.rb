class FollowRequestsController < ApplicationController

  def create
    member = Member.find(params[:member_id])
    follow_request = current_member.active_follow_requests.create(followed_id: member.id)
    follow_request.notifications.create(member_id: member.id)
    redirect_to member_path(member)
  end

  def approve
    member = Member.find(params[:member_id])
    relationship = member.active_relationships.create(followed_id: current_member.id)
    relationship.notifications.create(member_id: member.id)
    member.active_follow_requests.find_by(followed_id: current_member.id).destroy
    redirect_to member_path(member)
  end

  def destroy
      member = Member.find(params[:member_id])
      member.active_follow_requests.find_by(followed_id: current_member.id).destroy
      redirect_to home_path
  end
end
