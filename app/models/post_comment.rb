class PostComment < ApplicationRecord
    belongs_to :member
    belongs_to :target_feed, class_name: "Feed", foreign_key: "target_feed_id"
    # belongs_to :parent_post_comment, class_name: "PostComment", foreign_key: "target_post_comment_id"

    # has_many :replies, class_name: "PostComment", foreign_key: "target_post_comment_id", dependent: :destroy

    validates :comment, presence: true
end
