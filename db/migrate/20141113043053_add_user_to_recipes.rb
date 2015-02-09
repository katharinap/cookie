class AddUserToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :user_id, :integer

    reversible do |dir|
      dir.up do
        default_user = User.first
        Recipe.all.each { |recipe| recipe.user = default_user; recipe.save }
      end    
    end
  end
end
