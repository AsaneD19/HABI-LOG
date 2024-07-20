class ReplyComment < ApplicationRecord
  belongs_to :member
  belongs_to :post_comment
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

end
