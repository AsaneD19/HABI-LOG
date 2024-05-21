class NotificationsController < ApplicationController

  def update
    notification = current_member.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    when "Relationship"
      redirect_to member_path(notification.notifiable.follower)
    else
      redirect_to notification_path(notification)
    end
    # when "FollowRequest"
    #   redirect_to member_follow_request_path
  end

  def show
    @notification = current_member.notifications.find(params[:id])
    byebug
  end
end
