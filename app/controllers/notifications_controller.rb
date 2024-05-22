class NotificationsController < ApplicationController

  def update
    notification = current_member.notifications.find(params[:id])
    unless notification.notifiable_type == "FollowRequest" && notification.notifiable.is_approval == nil
      notification.update(read: true)
    end
    redirect_to notification_path(notification)
  end

  def show
    @notification = current_member.notifications.find(params[:id])
  end

  def index
    @notifications = current_member.notifications.where(read: false)
  end
end
