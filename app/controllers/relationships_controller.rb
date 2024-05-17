class RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    current_member.follow(params[:member_id])
    redirect_to member_path(current_member)
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to member_path(current_member)
  end

  # フォローしている人一覧
  def follower
    member = member.find(params[:member_id])
    @members = member.followings
  end

  # フォローされている人一覧
  def followed
    member = member.find(params[:member_id])
    @members = member.followers
  end


end
