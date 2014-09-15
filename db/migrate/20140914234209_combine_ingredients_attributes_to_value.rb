class CombineIngredientsAttributesToValue < ActiveRecord::Migration
  def up
    add_column :ingredients, :value, :string
    Ingredient.all.each do |ingredient|
      value = [ingredient.amount, ingredient.name].join(' ')
      value = "#{value} (#{ingredient.notes})" unless ingredient.notes.blank?
      ingredient.value = value
      ingredient.save
    end

    %i(amount name notes).each do |col|
      remove_column :ingredients, col
    end
  end

  def down
    %i(amount name notes).each do |col|
      add_column :ingredients, col, :string
    end

    Ingredient.all.each do |ingredient|
      if /^(<?amount>.+\s+\w)\s+(<?name>)$/ =~ ingredient.value
        ingredient.amount = amount
        ingredient.name = name
      else
        ingredient.name = ingredient.value
      end
      ingredient.save
    end

    remove_column :ingredients, :value
  end
end
