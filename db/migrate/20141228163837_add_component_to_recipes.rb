class AddComponentToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :component, :boolean, default: false
  end
end
