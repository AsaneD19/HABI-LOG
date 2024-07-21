class Public::TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @feeds = Feed.joins(:habit).where(habits: { tag_id: @tag.id }).order(created_at: :desc)
  end
end
