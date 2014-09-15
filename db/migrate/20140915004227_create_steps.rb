class CreateSteps < ActiveRecord::Migration
  def up
    create_table :steps do |t|
      t.integer :recipe_id
      t.integer :idx
      t.text :description

      t.timestamps null: false
    end

    Recipe.all.each do |recipe|
      recipe.steps.each_with_index do |description, idx|
        Step.create(recipe_id: recipe.id, idx: idx, description: description)
      end
    end

    remove_column :recipes, :directions
  end

  def down
    add_column :recipes, :directions, :text
    Recipe.all.each do |recipe|
      recipe.directions = recipe.steps.join("\n")
      recipe.save
    end

    drop_table :steps
  end
end
