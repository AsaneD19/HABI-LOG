class Favorite < ApplicationRecord

  belongs_to :member
  belongs_to :favorable, polymorphic: true

  validates_uniqueness_of :member_id, scope: [:favorable_type, :favorable_id]

end
