class PostComment < ApplicationRecord
  belongs_to :member
  belongs_to :feed
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  after_create do
    notifications.create(member_id: feed.member_id)
  end

end
