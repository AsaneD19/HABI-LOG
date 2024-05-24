class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references  :member,      null: false,  foreign_key: true
      t.references  :notifiable,  null: false,  polymorphic: true
      t.boolean     :read,        null: false,  default: false
      t.timestamps
    end
  end
end
