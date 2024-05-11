class Habit < ApplicationRecord
  belongs_to :member
  belongs_to :tag
  has_many :habit_progresses, dependent: :destroy

  validates :name, presence: true
  validates :comment, presence: true

end
