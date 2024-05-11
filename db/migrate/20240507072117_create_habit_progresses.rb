class CreateHabitProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :habit_progresses do |t|

      t.text    :comment,           null: false
      t.integer :current_duration,  null: false
      t.integer :habit_id,          null: false

      t.timestamps
    end
  end
end
