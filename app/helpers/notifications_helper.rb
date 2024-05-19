module NotificationsHelper

  def notification_message(notification)
    case notification.notifiable_type
    when "Relationship"
      "#{notification.notifiable.member.name}さんにふぉろーされました。"
    when "PostComment"
      "#{notification.notifiable.member.name}さんにコメントされました。"
    when "Favorite"
      "#{notification.notifiable.member.name}さんにいいねされました。"
    end
  end
end
