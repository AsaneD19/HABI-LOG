class PostCommentsController < ApplicationController

  def new

  end
  def create
    @post_comment = PostComment.new(post_comment_params)
    @feed = Feed.find(params[:feed_id])
    @post_comment.member_id = current_member.id
    @post_comment.target_feed_id = @feed.id

    if @post_comment.save
      flash[:notice] = "Your comment to feed has succeeded."
      redirect_to feed_path(params[:feed_id])
    else
      flash[:alert] = @post_comment.errors.full_messages.join(", ")
      @post_comments = @feed.post_comments
      render "feeds/show"
    end

  end
  def index

  end
  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = "Your comment has been deleted successfully."
    redirect_to feed_path(params[:feed_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:member_id, :target_feed_id, :target_post_comment_id, :comment)
  end
end
