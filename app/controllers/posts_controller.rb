class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_user.id
    if @post.save
      redirect_to
    else
    end
  end

  def index
  end

  def show
  end

  def update
  end

  def destroy
  end

  def timeline
  end
end
