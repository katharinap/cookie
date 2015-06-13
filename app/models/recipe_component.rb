# == Schema Information
#
# Table name: recipe_components
#
#  id           :integer          not null, primary key
#  recipe_id    :integer
#  component_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class RecipeComponent < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :component, class_name: 'Recipe'
end
