class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :user_id
      t.integer :likes_count, default: 0

      t.timestamps
    end
  end
end
