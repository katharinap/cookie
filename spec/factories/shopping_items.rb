# == Schema Information
#
# Table name: shopping_items
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean          default("true")
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shopping_item do
    sequence(:name) { |n| "#{n.ordinalize} shopping item" }
    user
  end
end
