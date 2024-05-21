class FavoritesController < ApplicationController

  def create
    @favorable = find_favorable
    current_member.favorites.create(favorable: @favorable)
    redirect_back(fallback_location: home_path)
  end

  def destroy
    @favorable = find_favorable
    current_member.favorites.find_by(favorable: @favorable).destroy
    redirect_back(fallback_location: home_path)
  end

  def index
    @favorables = find_favorable
  end

  private

  def find_favorable
    params[:favorable_type].constantize.find(params[:favorable_id])
  end
end
