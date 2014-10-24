module ApplicationHelper
  # if @recipe is defined, returns its name, nil otherwise
  def title
    @recipe ? @recipe.name : nil
  end

  def new_icon
    image_tag('new-icon.png', alt: t('.new', default: t("helpers.links.new")))
  end
end
