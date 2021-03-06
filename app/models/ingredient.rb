# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  value      :string
#
class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :value, presence: true
  before_save :strip_whitespace

  private

  def strip_whitespace
    value.strip!
  end
end
