# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  directions :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :recipe do
    sequence :name do |n|
      "Awesome Recipe #{n}"
    end
    directions "First do something, then do something else"
  end
end
