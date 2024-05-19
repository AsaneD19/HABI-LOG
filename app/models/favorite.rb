class Favorite < ApplicationRecord

  belongs_to :member
  belongs_to :favorable, polymorphic: true
  has_one :notifications, as: :notificable, dependent: :destroy
  validates_uniqueness_of :member_id, scope: [:favorable_type, :favorable_id]

end
