require 'rails_helper'

RSpec.describe "recipes/index", :type => :view do
  before(:each) do
    assign(:recipes, (1..5).map{ |i| stub_recipe(i) })
  end

  it "renders a list of recipes" do
    render
    (1..5).each do |i|
      assert_select "tr>td>a[href=?]", recipe_path(i), text: "#{i.ordinalize} Recipe", count: 1
      assert_select "tr>td>a[href=?]", edit_recipe_path(i)
      assert_select "tr>td>a[href=?][data-method=?][data-confirm=?]", recipe_path(i), 'delete', 'Are you sure?'
    end
    assert_select "a[href=?]", new_recipe_path
  end

  protected

  def stub_recipe(id)
    stub_model(Recipe, attributes_for(:recipe, id: id.to_s, name: "#{id.ordinalize} Recipe", directions: 'do something...', created_at: Time.now))
  end
end
