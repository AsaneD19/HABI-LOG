class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "Member"
  belongs_to :followed, class_name: "Member"
  has_many :notifications, as: :notificable, dependent: :destroy

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
