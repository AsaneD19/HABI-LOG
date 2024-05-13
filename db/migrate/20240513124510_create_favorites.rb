class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.integer :member_id,               null: false
      t.integer :target_feed_id
      t.integer :tatget_post_comment_id

      t.timestamps
    end
  end
end
