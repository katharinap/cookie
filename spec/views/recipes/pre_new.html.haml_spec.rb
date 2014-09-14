require 'rails_helper'

RSpec.describe "recipes/pre_new", :type => :view do
  it "renders pre_new recipe form" do
    render
    puts rendered
    assert_select "form[action=?]", new_recipe_path do
      assert_select "input#name[name=?]", "name"
      assert_select "textarea#ingredients[name=?]", "ingredients"
      assert_select "textarea#directions[name=?]", "directions"
    end
  end
end
