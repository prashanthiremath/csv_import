class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :description
      t.string :status
      t.string :sales_type
      t.integer :item_number
      t.string :category
      t.timestamps
    end
    add_index :products, :item_number, unique: true
  end
end
