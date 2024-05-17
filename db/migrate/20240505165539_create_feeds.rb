class CreateFeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :feeds do |t|

      t.integer :member_id,           null: false
      t.integer :habit_id,            null: false
      t.text    :text_content,        null: false
      t.integer :current_duration,    null: false, default: 0

      t.timestamps
    end
  end
end
