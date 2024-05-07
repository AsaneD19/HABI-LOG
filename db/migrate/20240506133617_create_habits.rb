class CreateHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :habits do |t|

      t.string  :name,             null: false
      t.integer :count,            null: false, default: 0
      t.text    :comment
      t.date    :last_achievement
      t.integer :duration,         null: false, default: 0
      t.integer :max_duration,     null: false, default: 0
      t.integer :member_id,        null: false
      t.integer :tag_id,           null: false

      t.timestamps
    end
  end
end
