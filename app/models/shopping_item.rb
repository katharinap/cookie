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
class ShoppingItem < ActiveRecord::Base
  belongs_to :user
end
