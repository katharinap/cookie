module RecipesHelper
  def allow_edit?(recipe)
    return false unless current_user
    recipe.user_id == current_user.id
  end
end
