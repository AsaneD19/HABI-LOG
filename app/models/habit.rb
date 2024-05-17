class Habit < ApplicationRecord
  belongs_to :member
  belongs_to :tag
  has_many :feeds,         dependent: :destroy
  has_many :habit_records, dependent: :destroy

  validates :name, presence: true
  validates :caption, presence: true

end
