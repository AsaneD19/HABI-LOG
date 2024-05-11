class Feed < ApplicationRecord
  belongs_to :member
  belongs_to :habit
end
