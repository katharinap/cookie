require 'rails_helper'

RSpec.describe "ingredients/new", :type => :view do
  before(:each) do
    assign(:ingredient, Ingredient.new(
      :recipe_id => 1,
      :additive => "MyString",
      :amount => "MyString"
    ))
  end

  it "renders new ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredients_path, "post" do

      assert_select "input#ingredient_recipe_id[name=?]", "ingredient[recipe_id]"

      assert_select "input#ingredient_additive[name=?]", "ingredient[additive]"

      assert_select "input#ingredient_amount[name=?]", "ingredient[amount]"
    end
  end
end
