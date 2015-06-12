class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :user, :ingredients, :steps, :references
  belongs_to :user
  has_many :ingredients
  has_many :steps
  has_many :references
  # , :ingredients, :steps, :references
end
