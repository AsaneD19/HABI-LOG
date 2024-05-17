class CreateHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :habits do |t|

      t.integer     :member_id,         null: false
      t.string      :name,              null: false
      t.integer     :achievement_count, null: false, default: 0
      t.text        :caption
      t.datetime    :last_achievement
      t.integer     :current_duration,  null: false, default: 0
      t.integer     :max_duration,      null: false, default: 0
      t.integer     :tag_id,            null: false

      t.timestamps
    end
  end
end
