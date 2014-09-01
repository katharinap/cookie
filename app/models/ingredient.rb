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

class Ingredient < ActiveRecord::Base
  belongs_to :recipe
end
