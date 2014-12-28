require 'rails_helper'

RSpec.describe "recipes/show", :type => :view do
  before(:each) do
    recipe = stub_recipe
    assign :recipe, recipe
    allow(recipe).to receive(:ingredients).and_return((1..5).map{ |i| stub_ingredient(i, recipe) })
    allow(recipe).to receive(:steps).and_return((1..5).map{ |i| stub_step(i, recipe) })
    allow(view).to receive(:allow_edit?).and_return(true)
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
  end

  it "displays the user's name" do
    render
    expect(rendered).to have_selector('i[class="glyphicon glyphicon-user"]', count: 1)
    expect(rendered).to match(/chef/)
  end
  
  it 'shows the edit and delete button if the current user owns the recipe' do
    render
    expect(rendered).to have_selector("a[href='#{edit_recipe_path(1)}']", count: 1)
    expect(rendered).to have_selector("a[href='#{recipe_path(1)}'][data-method='delete']", count: 1)
  end

  it 'does not show the edit and delete button if the current user does not own the recipe' do
    allow(view).to receive(:allow_edit?).and_return(false)
    render
    expect(rendered).to have_selector("a[href='#{edit_recipe_path(1)}']", count: 0)
    expect(rendered).to have_selector("a[href='#{recipe_path(1)}'][data-method='delete']", count: 0)
  end

  protected

  def stub_recipe
    recipe = stub_model(Recipe, attributes_for(:recipe, id: '1', name: 'A Delicious Recipe'))
    allow(recipe).to receive(:user) { stub_model(User, attributes_for(:user, name: 'chef')) }
    recipe
  end

  def stub_ingredient(i, recipe)
    stub_model(Ingredient, attributes_for(:ingredient, recipe_id: recipe.id, value: "#{i} cup ingredient #{i}"))
  end

  def stub_step(i, recipe)
    stub_model(Step, attributes_for(:step, recipe_id: recipe.id, description: "step #{i}"))
  end
end
