# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string
#  user_id    :integer
#  component  :boolean          default("false")
#

FactoryGirl.define do
  factory :recipe do
    user
    sequence :name do |n|
      "Awesome Recipe #{n}"
    end
    created_at Time.now
  end
end
