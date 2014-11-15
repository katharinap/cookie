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
#

class Recipe < ActiveRecord::Base
  include WithPicture
  has_default_picture_size [400, 400]
  has_thumb_picture_size   [50, 50]
  
  validates :name, uniqueness: true, presence: true

  belongs_to :user
  
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: proc { |attributes| attributes['value'].blank? }

  has_many :references, dependent: :destroy
  accepts_nested_attributes_for :references, allow_destroy: true

  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }

  def user_name
    user ? user.name : 'N/A'
  end
  
  def prepare_recipe(params)
    self.name = params[:name].strip unless params[:name].blank?

    %i(ingredients directions).each do |attr|
      params[attr].split("\n").each do |attr_str|
        unless attr_str.strip.blank?
          case attr
          when :ingredients
            ingredients.build(value: attr_str.strip)
          when :directions
            steps.build(description: attr_str.strip) 
          end
        end
      end
    end
  end
end
