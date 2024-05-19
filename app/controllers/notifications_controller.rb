class NotificationsController < ApplicationController

  def update
    notification = current_member.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    when "PostComment"
      redirect_to feed_path(notification.notifiable.feed)
    when "Favorite"
      redirect_to member_path(notification.notifiable.member)
    else
      redirect_to member_path(notification.notifiable.member)
    end
  end
end
