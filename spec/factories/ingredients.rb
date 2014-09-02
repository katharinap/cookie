# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  name       :string
#  amount     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  notes      :string
#

FactoryGirl.define do
  factory :ingredient do
    recipe
    name "MyString"
    amount "8 oz dry round udon noodles"
  end
end
