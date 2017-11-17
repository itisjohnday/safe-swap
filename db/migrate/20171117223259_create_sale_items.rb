class CreateSaleItems < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_items do |t|
      t.string :title
      t.timestamps
    end
  end
end
