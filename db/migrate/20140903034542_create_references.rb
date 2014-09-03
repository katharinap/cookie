class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :url
      t.integer :recipe_id

      t.timestamps null: false
    end
  end
end
