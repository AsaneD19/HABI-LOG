class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :member_id,   null: false
      t.integer :habit_id,    null: false
      t.string  :habit_name,  null: false
      t.string  :tag_name,    null: false
      t.integer :type,        null: false
      t.text    :comment,     null: false
      t.integer :duration,    null: false, default: 0

      t.timestamps
    end
  end
end
