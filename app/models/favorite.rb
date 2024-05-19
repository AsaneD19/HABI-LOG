class Favorite < ApplicationRecord

  belongs_to :member
  belongs_to :favorable, polymorphic: true
  has_one :notification, as: :notifiable, dependent: :destroy
  validates_uniqueness_of :member_id, scope: [:favorable_type, :favorable_id]

  after_create do
    create_notification(member_id: favorable.member_id)
  end

end
