require 'rails_helper'

RSpec.describe "recipes/index", :type => :view do
  before(:each) do
    assign(:recipes, [
             create(:recipe, directions: "MyText", name: "Recipe Name 1"),
             create(:recipe, directions: "MyText", name: "Recipe Name 2")
    ])
  end

  it "renders a list of recipes" do
    render
    assert_select "tr>td", :text => "Recipe Name 1".to_s, :count => 1
    assert_select "tr>td", :text => "Recipe Name 2".to_s, :count => 1
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
