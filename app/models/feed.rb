class Feed < ApplicationRecord
  belongs_to :member
  belongs_to :habit

  has_many :post_comments, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

end
