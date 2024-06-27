class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :feeds, dependent: :destroy
  has_many :habits, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :active_follow_requests, class_name: "FollowRequest", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow_requests, class_name: "FollowRequest", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :notifications, dependent: :destroy

  has_one_attached :profile_image

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
  validates :account_id, presence: true, uniqueness: true, length: { in: 4..15 }
  validates :name, presence: true, length: { in: 1..50 }
  validates :introduction, length: { maximum: 160 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def following?(member)
    followings.include?(member)
  end

  def follow_request_approved?(member)
    approvals.include?(member)
  end

  def requested?(member)
    active_follow_requests.exists?(followed_id: member.id)
  end

end