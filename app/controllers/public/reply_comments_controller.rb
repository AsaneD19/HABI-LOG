class Public::ReplyCommentsController < ApplicationController
  include CheckMemberStatus
  before_action :is_guest_member?
  before_action ->{is_matching_login_member(ReplyComment.find(params[:id]).member)}, only: [:destroy]

  def create
    byebug
    @reply_comment = set_reply_comment_params(ReplyComment.new(reply_comment_params), params[:post_comment_id])
    byebug
    if @reply_comment.save
      flash[:notice] = "Your reply to post comment has succeeded."
      unless @reply_comment.post_comment.member == @reply_comment.member
        @reply_comment.notifications.create(member_id: @reply_comment.post_comment.member_id)
      end
      redirect_to feed_path(params[:feed_id])
    else
      flash[:alert] = @reply_comment.errors.full_messages.join(", ")
      @post_comment = PostComment.find(@reply_comment.post_comment_id)
      @reply_comments = @ponextst_comment.reply_comments
      @reply_comment = ReplyComment.new(post_comment_id: @post_comment.id)
      render "post_comments/show"
    end
  end

  def destroy
    reply_comment = ReplyComment.find(params[:id])
    reply_comment.destroy
    flash[:notice] = "Your comment has been deleted successfully."
    redirect_to feed_post_comment_path(params[:post_comment_id])

  end

  private
  def reply_comment_params
    params.require(:reply_comment).permit(:member_id, :post_comment_id, :content)
  end

  def set_reply_comment_params(reply_comment, post_comment_id)
    reply_comment.member_id = current_member.id
    reply_comment.post_comment_id = post_comment_id
    return reply_comment
  end

end
