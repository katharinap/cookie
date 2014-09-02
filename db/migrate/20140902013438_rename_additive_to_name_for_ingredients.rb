class RenameAdditiveToNameForIngredients < ActiveRecord::Migration
  def change
    rename_column :ingredients, :additive, :name
    add_column :ingredients, :notes, :string
  end
end
