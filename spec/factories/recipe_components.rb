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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe_component do
    recipe_id 1
    component_id 2
  end
end
