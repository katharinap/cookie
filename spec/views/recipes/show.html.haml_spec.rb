require 'rails_helper'

RSpec.describe "recipes/show", :type => :view do
  before(:each) do
    recipe = stub_recipe
    assign :recipe, recipe
    allow(recipe).to receive(:ingredients).and_return((1..5).map{ |i| stub_ingredient(i, recipe) })
    allow(recipe).to receive(:steps).and_return((1..5).map{ |i| stub_step(i, recipe) })
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
    assert_select 'a[href=?]', edit_recipe_path('1')
    assert_select 'a[href=?][data-method=?][data-confirm=?]', recipe_path('1'), 'delete', 'Are you sure?'
  end

  protected

  def stub_recipe
    stub_model(Recipe, attributes_for(:recipe, id: '1', name: 'A Delicious Recipe'))
  end

  def stub_ingredient(i, recipe)
    stub_model(Ingredient, attributes_for(:ingredient, recipe_id: recipe.id, value: "#{i} cup ingredient #{i}"))
  end

  def stub_step(i, recipe)
    stub_model(Step, attributes_for(:step, recipe_id: recipe.id, description: "step #{i}"))
  end
end
