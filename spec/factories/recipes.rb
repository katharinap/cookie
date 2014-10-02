# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string
#

FactoryGirl.define do
  factory :recipe do
    sequence :name do |n|
      "Awesome Recipe #{n}"
    end
  end
end
