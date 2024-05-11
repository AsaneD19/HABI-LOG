class FeedsController < ApplicationController

  def new
  end

  def create
  end

  def index
    @feeds = @member.Feeds
  end

  def show
  end

  def update
  end

  def destroy
  end

  def timeline
    @feeds = Feed.all
  end
end
