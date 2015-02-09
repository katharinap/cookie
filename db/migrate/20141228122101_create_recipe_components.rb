class CreateRecipeComponents < ActiveRecord::Migration
  def change
    create_table :recipe_components do |t|
      t.integer :recipe_id
      t.integer :component_id

      t.timestamps null: false
    end
  end
end
