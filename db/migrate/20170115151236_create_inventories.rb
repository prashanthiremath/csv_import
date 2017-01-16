class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.string :status
      t.integer :item_number
      t.integer :org_number
      t.date :last_ship_date
      t.date :due_date
      t.date :extract_date
      t.integer :quantity
      t.integer :lot
      t.timestamps
    end
    add_index :inventories, [:item_number,:org_number,:lot], unique: true
    add_index :inventories, [:item_number,:org_number], unique: true
  end
end
