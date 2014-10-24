class AddActiveToShoppingItems < ActiveRecord::Migration
  def change
    add_column :shopping_items, :active, :boolean, default: true
  end
end
