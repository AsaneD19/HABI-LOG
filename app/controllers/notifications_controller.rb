class NotificationsController < ApplicationController

  def update
    notification = current_member.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification_path(notification)
  end

  def show
    @notification = current_member.notifications.find(params[:id])
  end

  def index
    @notifications = current_member.notifications.all
  end
end
