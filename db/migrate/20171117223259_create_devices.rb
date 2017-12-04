class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :title
      t.string :model, null: false
      t.string :manufacturer, null: false
      t.string :condition, null: false
      t.integer :price, null: false
      t.boolean :sold?, default: false
      t.integer :seller_id
      t.integer :buyer_id

      t.timestamps
    end
  end
end
