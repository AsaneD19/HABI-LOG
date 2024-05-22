class CreateFollowRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_requests do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false
      t.boolean :is_approval, default: false
      t.timestamps
    end
  end
end
