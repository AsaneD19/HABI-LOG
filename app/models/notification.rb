class Notification < ApplicationRecord
  belongs_to :member
  belongs_to :notificable, polymorphic: true
end
