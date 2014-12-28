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

  has_many :recipe_components, dependent: :destroy
  accepts_nested_attributes_for :recipe_components, allow_destroy: true, reject_if: proc { |attributes| attributes['component_id'].blank? }
  has_many :components, through: :recipe_components, class_name: 'Recipe'
  accepts_nested_attributes_for :components, allow_destroy: true

  scope :component, -> { where(component: true) }
  
  def user_name
    user ? user.name : 'N/A'
  end
  
  def prepare_recipe(params)
    self.name = params[:name].try(:strip)
    self.user_id = params[:user_id]
    
    %i(ingredients directions references).each do |attr|
      next if params[attr].blank?
      params[attr].split("\n").map(&:strip).each do |str|
        next if str.blank?
        case attr
        when :ingredients
          ingredients.build(value: str)
        when :directions
          steps.build(description: str)
        when :references
          references.build(url: str)
        end
      end
    end

    self
  end
end
