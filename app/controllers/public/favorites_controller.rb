class Public::FavoritesController < ApplicationController
  include CheckMemberStatus
  before_action :is_guest_member?

  def create
    favorable = find_favorable
    favorite = current_member.favorites.create(favorable: favorable)
    Notification.create(member_id: favorable.member_id, notifiable_type: "Favorite", notifiable_id: favorite.id)
    redirect_back(fallback_location: home_path)
  end

  def destroy
    favorable = find_favorable
    current_member.favorites.find_by(favorable: favorable).destroy
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
