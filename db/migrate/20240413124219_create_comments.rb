class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null:false, default: 0
      t.integer :post_id, null:false,  default: 0
      t.text :body
      t.timestamps
    end
  end
end
