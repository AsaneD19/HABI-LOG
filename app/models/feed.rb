class Feed < ApplicationRecord
  belongs_to :member
  belongs_to :habit

  has_many :post_comments, foreign_key: "target_feed_id", dependent: :destroy
  has_many :favorites, foreign_key: "target_feed_id", dependent: :destroy
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

end
