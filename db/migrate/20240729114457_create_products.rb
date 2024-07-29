class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :status, null: false, default: 0
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :product_type, null: false
      t.text :description

      t.references :shop, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :updater, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
