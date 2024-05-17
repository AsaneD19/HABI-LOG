class FavoritesController < ApplicationController

  def create

    feed = Feed.find(params[:feed_id])
    favorite = current_member.favorites.new
    favorite.target_feed_id = feed.id
    favorite.save
    redirect_to feed_path(feed)
  end

  def destroy
    feed = Feed.find(params[:feed_id])
    favorite = current_member.favorites.find_by(target_feed_id: feed.id)
    favorite.destroy
    redirect_to feed_path(feed)
  end

  private
  def habit_params
    params.require(:favorite).permit(:member_id, :target_feed_id, :target_post_comment_id)
  end

end
