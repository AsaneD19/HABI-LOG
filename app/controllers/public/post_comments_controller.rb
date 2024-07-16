class Public::PostCommentsController < ApplicationController
  include CheckMemberStatus
  before_action :is_guest_member?
  before_action ->{is_matching_login_member(PostComment.find(params[:id]).member)}, only: [:destroy]

  def create
    @post_comment = set_post_comment_params(PostComment.new(post_comment_params), params[:feed_id])
    if @post_comment.save
      flash[:notice] = "Your comment to feed has succeeded."
      unless @post_comment.feed.member == @post_comment.member
        @post_comment.notifications.create(member_id: @post_comment.feed.member_id)
      end
      redirect_to feed_path(params[:feed_id])
    else
      flash[:alert] = @post_comment.errors.full_messages.join(", ")
      @post_comments = @feed.post_comments
      render "feeds/show"
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = "Your comment has been deleted successfully."
    redirect_to feed_path(params[:feed_id])
  end

  def show
    @post_comment = PostComment.find(params[:id])
    @reply_comments = @post_comment.reply_comments
    @reply_comment = ReplyComment.new
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:member_id, :feed_id, :content)
  end

  def set_post_comment_params(post_comment, feed_id)
    post_comment.member_id = current_member.id
    post_comment.feed_id = feed_id
    return post_comment
  end

end