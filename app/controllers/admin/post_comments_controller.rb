class Admin::PostCommentsController < ApplicationController
  layout "admin"
  def index
    @member = Member.find(params[:member_id])
    @post_comments = @member.post_comments
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    member = post_comment.member
    post_comment.destroy
    redirect_to admin_member_post_comments_path(member)
  end
end
