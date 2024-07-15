class CreateReplyComments < ActiveRecord::Migration[6.1]
  def change
    create_table :reply_comments do |t|
      t.integer :member_id,           null: false
      t.integer :post_comment_id,     null: false
      t.text    :content,             null: false
      t.timestamps
    end
  end
end
