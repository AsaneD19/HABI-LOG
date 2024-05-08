class HabitProgress < ApplicationRecord
  belongs_to :habit

  validates :comment, presence: true
end
