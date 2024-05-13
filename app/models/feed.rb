class Feed < ApplicationRecord
  belongs_to :member
  belongs_to :habit
  
  has_many :post_comments, foreign_key: "target_feed_id", dependent: :destroy
end
