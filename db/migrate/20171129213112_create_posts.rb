class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :content, null: false

      t.belongs_to :user
      t.belongs_to :device

      t.timestamps
    end
  end
end
