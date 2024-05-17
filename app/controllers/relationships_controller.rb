class RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    byebug
    current_member.follow(params[:member_id])
    redirect_to member_path(params[:member_id])
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to member_path(params[:member_id])
  end

  def follower
    member = member.find(params[:member_id])
    @members = member.followings
  end

  def followed
    member = member.find(params[:member_id])
    @members = member.followers
  end


end
