class PostComment < ApplicationRecord
    belongs_to :member
    belongs_to :target_feed, class_name: "Feed", foreign_key: "target_feed_id"

    validates :content, presence: true
end
