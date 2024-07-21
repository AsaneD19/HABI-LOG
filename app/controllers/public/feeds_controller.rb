class Public::FeedsController < ApplicationController
  include CheckMemberStatus
  before_action :is_guest_member?, only: [:destroy]
  before_action ->{is_matching_login_member(Feed.find(params[:id]).member)}, only: [:destroy]

  def index
    @feeds = Feed.where.order(created_at: :desc)

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
