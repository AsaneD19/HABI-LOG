class FeedsController < ApplicationController

  def create

  end

  def index
    @feeds = Feed.all.order(created_at: :desc)
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
