class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer  :user_id,    null:false,  default: 0
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
