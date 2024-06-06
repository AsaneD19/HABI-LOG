class Public::FeedsController < ApplicationController
  include CheckMember
  before_action :is_guest_member?, only: [:destroy]
  before_action :is_matching_login_member, only: [:destroy]

  def index
    @feeds = Feed.joins(:member).where(members: { is_active: true }).where(members: { is_private: false }).order(created_at: :desc)
  end

  def show
    @feed = Feed.find(params[:id])
    @post_comments = @feed.post_comments
    @post_comment = PostComment.new
  end

  def destroy
    feed = Feed.find(params[:id])
    feed.destroy
    flash[:notice] = "You have deleted a feed successfully."
    redirect_to home_path
  end

end
