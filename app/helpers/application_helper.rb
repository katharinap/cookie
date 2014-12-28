module ApplicationHelper
  def title
    @recipe.try :name
  end

  def current_user_id
    current_user.try :id
  end

  def new_icon
    image_tag('new-icon.png', alt: t('.new', default: t("helpers.links.new")))
  end
end
