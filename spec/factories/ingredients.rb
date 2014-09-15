# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  value      :string
#

FactoryGirl.define do
  factory :ingredient do
    recipe
    sequence(:value) { |n| "#{rand(10)} cups #{n.ordinalize} Ingredient" }
  end
end
