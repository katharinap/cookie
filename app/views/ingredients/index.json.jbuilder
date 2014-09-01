json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :recipe_id, :additive, :amount
  json.url ingredient_url(ingredient, format: :json)
end
