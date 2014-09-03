module ApplicationHelper
  # if @recipe is defined, returns its name, nil otherwise
  def title
    @recipe ? @recipe.name : nil
  end
end
