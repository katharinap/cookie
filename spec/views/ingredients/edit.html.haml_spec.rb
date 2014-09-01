require 'rails_helper'

RSpec.describe "ingredients/edit", :type => :view do
  before(:each) do
    @ingredient = assign(:ingredient, Ingredient.create!(
      :recipe_id => 1,
      :additive => "MyString",
      :amount => "MyString"
    ))
  end

  it "renders the edit ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredient_path(@ingredient), "post" do

      assert_select "input#ingredient_recipe_id[name=?]", "ingredient[recipe_id]"

      assert_select "input#ingredient_additive[name=?]", "ingredient[additive]"

      assert_select "input#ingredient_amount[name=?]", "ingredient[amount]"
    end
  end
end
