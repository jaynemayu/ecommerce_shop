class AddUniqueIndexToShopsName < ActiveRecord::Migration[7.1]
  def change
    add_index :shops, :name, unique: true
  end
end
