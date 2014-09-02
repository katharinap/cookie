# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  additive   :string
#  amount     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :ingredient do
    recipe
    additive "MyString"
    amount "8 oz dry round udon noodles"
  end
end
