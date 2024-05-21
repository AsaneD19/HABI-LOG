class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "Member"
  belongs_to :followed, class_name: "Member"
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create do
    notifications.create(member_id: followed.id)
  end
end
