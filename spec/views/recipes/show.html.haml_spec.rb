require 'rails_helper'

RSpec.describe "recipes/show", :type => :view do
  before(:each) do
    recipe = stub_recipe
    assign :recipe, recipe
    allow(recipe).to receive(:ingredients).and_return((1..5).map{ |i| stub_ingredient(i, recipe) })
  end

  it "renders attributes in <p>" do
    render
    assert_select "h1", text: "A Delicious Recipe", count: 1
    (1..5).each do |i|
      expect(rendered).to match(/#{i} cup/)
      expect(rendered).to match(/ingredient #{i}/)
    end
    assert_select 'p', text: 'step 1'
    assert_select 'p', text: 'step 2'
    assert_select 'a[href=?]', recipes_path, text: 'Back'
    assert_select 'a[href=?]', edit_recipe_path('1'), text: 'Edit'
    assert_select 'a[href=?][data-method=?][data-confirm=?]', recipe_path('1'), 'delete', 'Are you sure?', text: 'Delete'
  end

  protected

  def stub_recipe
    stub_model(Recipe, attributes_for(:recipe, id: '1', name: 'A Delicious Recipe', directions: "step 1\nstep 2"))
  end

  def stub_ingredient(i, recipe)
    stub_model(Ingredient, attributes_for(:ingredient, recipe_id: recipe.id, amount: "#{i} cup", name: "ingredient #{i}"))
  end
end
