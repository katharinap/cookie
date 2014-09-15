# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  directions :text
#

class Recipe < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  has_many :references, dependent: :destroy
  accepts_nested_attributes_for :references, allow_destroy: true

  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  
  def prepare_recipe(params)
    %i(name directions).each do |attr|
      self.send("#{attr}=", params[attr].strip) unless params[attr].blank?
    end
    
    unless params[:ingredients].blank?
      params[:ingredients].split("\n").each do |ingredient_str|
        ingredients.build(value: ingredient_str.strip) unless ingredient_str.strip.blank?
      end
    end
  end
end
