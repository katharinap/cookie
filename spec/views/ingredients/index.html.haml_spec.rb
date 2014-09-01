require 'rails_helper'

RSpec.describe "ingredients/index", :type => :view do
  before(:each) do
    assign(:ingredients, [
      Ingredient.create!(
        :recipe_id => 1,
        :additive => "Additive",
        :amount => "Amount"
      ),
      Ingredient.create!(
        :recipe_id => 1,
        :additive => "Additive",
        :amount => "Amount"
      )
    ])
  end

  it "renders a list of ingredients" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Additive".to_s, :count => 2
    assert_select "tr>td", :text => "Amount".to_s, :count => 2
  end
end
