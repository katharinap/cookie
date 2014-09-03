# == Schema Information
#
# Table name: references
#
#  id         :integer          not null, primary key
#  url        :string
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reference do
    recipe
    url "http://www.example.com/myrecipe2/1"
  end
end
