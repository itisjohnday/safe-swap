class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :title
      t.string :model
      t.string :manufacturer
      t.string :condition
      t.integer :price
      t.boolean :sold?

      t.belongs_to :seller
      t.belongs_to :buyer

      t.timestamps
    end
  end
end
