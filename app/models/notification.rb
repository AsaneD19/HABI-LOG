class Notification < ApplicationRecord
  belongs_to :member
  belongs_to :notifiable, polymorphic: true
end
