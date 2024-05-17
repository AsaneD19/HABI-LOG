class Favorite < ApplicationRecord

  belongs_to :member
  belongs_to :feed, foreign_key: "target_feed_id"

  validates :member_id, uniqueness: {scope: :target_feed_id}

end
