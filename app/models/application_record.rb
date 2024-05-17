class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ransackable_associations(auth_object = nil)
    ["member"]
  end
end
