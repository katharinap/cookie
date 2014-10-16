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

class Recipe < ActiveRecord::Base
  include WithPicture
  has_default_picture_size [800, 800]
  has_thumb_picture_size   [50, 50]
  
  validates :name, uniqueness: true, presence: true

  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: proc { |attributes| attributes['value'].blank? }

  has_many :references, dependent: :destroy
  accepts_nested_attributes_for :references, allow_destroy: true

  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }
  
  def prepare_recipe(params)
    self.name = params[:name].strip unless params[:name].blank?
    
    unless params[:ingredients].blank?
      params[:ingredients].split("\n").each do |ingredient_str|
        ingredients.build(value: ingredient_str.strip) unless ingredient_str.strip.blank?
      end
    end
  end
end
