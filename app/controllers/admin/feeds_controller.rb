class Admin::FeedsController < ApplicationController
  layout "admin"
  def index
    @member = Member.find(params[:format])
    @feeds = Feed.where(member_id: @member.id)
  end

  def show
    @feed = Feed.find(params[:id])
    @member = Member.find(@feed.member_id)
    @post_comments = PostComment.where(feed_id: @feed.id)
  end


  def destroy
    feed = Feed.find(params[:id])
    habit = Habit.find(feed.habit_id)
    feed.destroy
    habit.destroy
    redirect_back(fallback_location: admin_dashboards_path)
  end
end
