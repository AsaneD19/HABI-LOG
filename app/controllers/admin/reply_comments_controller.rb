class Admin::ReplyCommentsController < ApplicationController
  layout "admin"
  def index
    @member = Member.find(params[:member_id])
    @reply_comments = @member.reply_comments
  end

  def destroy
    reply_comment = ReplyComment.find(params[:id])
    member = reply_comment.member
    reply_comment.destroy
    redirect_to admin_member_reply_comments_path(member)
  end

end
