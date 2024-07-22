class Admin::FeedsController < ApplicationController
  layout "admin"
  def index
    @member = Member.find(params[:member_id])
    @feeds = Feed.where(member_id: @member.id)
  end

  def destroy
    feed = Feed.find(params[:id])
    feed.destroy
    redirect_back(fallback_location: admin_dashboards_path)
  end
end
