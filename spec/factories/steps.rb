# == Schema Information
#
# Table name: steps
#
#  id          :integer          not null, primary key
#  recipe_id   :integer
#  idx         :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  picture     :string
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :step do
    recipe
    sequence(:idx) { |n| n }
    description "MyText"
  end
end
