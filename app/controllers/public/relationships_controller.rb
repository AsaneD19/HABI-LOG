class Public::RelationshipsController < ApplicationController
  include CheckMemberStatus
  before_action :is_guest_member?
  before_action ->{is_private_member?(Member.find(params[:member_id]))}, only: [:follower, :followed]

  def create
    member = Member.find(params[:member_id])
    relationship = current_member.active_relationships.create(followed_id: member.id)
    relationship.notifications.create(member_id: member.id)
    redirect_to member_path(params[:member_id])
  end

  def destroy
    current_member.active_relationships.find_by(followed_id: params[:member_id]).destroy
    redirect_to member_path(params[:member_id])
  end

  def follower
    @member = Member.find(params[:member_id])
    @members = @member.followings
  end

  def followed
    @member = Member.find(params[:member_id])
    @members = @member.followers
  end

end
