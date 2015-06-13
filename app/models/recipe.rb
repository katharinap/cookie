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
  has_thumb_picture_size [50, 50]

  DEPENDENT_ATTRIBUTES = {
    ingredients: :value,
    steps: :description,
    references: :url,
    recipe_components: :component_id
  }

  validates :name, uniqueness: true, presence: true

  belongs_to :user

  DEPENDENT_ATTRIBUTES.each do |dependent, attr|
    has_many dependent, dependent: :destroy
    accepts_nested_attributes_for dependent,
                                  allow_destroy: true,
                                  reject_if: -> (params) { params[attr].blank? }
  end

  has_many :components, through: :recipe_components, class_name: 'Recipe'
  accepts_nested_attributes_for :components, allow_destroy: true

  scope :component, -> { where(component: true) }

  def user_name
    user ? user.name : 'N/A'
  end

  def prepare_recipe(params)
    self.name = params[:name].try(:strip)
    self.user_id = params[:user_id]
    self.component = params[:component]
    build_dependents(params)

    self
  end

  # builds ingredients, steps and references if specified in params
  # hash
  def build_dependents(params)
    DEPENDENT_ATTRIBUTES.each do |dependent, attr|
      next if params[dependent].blank?
      params[dependent].split("\n").map(&:strip).each do |str|
        next if str.blank?
        # e.g. ingredients.build(value: 'something ingredient')
        (send dependent).build(attr => str)
      end
    end
  end
end
