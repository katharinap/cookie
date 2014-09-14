require 'rails_helper'

RSpec.describe "recipes/edit", :type => :view do
  before(:each) do
    recipe = stub_recipe
    assign :recipe, recipe
    allow(recipe).to receive(:ingredients).and_return([stub_ingredient('1', recipe), stub_ingredient('2', recipe)])
  end
    
  it "renders the edit recipe form" do
    render
    assert_select "form[action=?][method=?]", recipe_path('1'), "post" do
      assert_select "input#recipe_name[name=?]", "recipe[name]"
      [1,2].each_with_index do |id, idx|
        %i(name amount notes id _destroy).each do |attr|
          assert_select "input#recipe_ingredients_attributes_#{idx}_#{attr}[name=?]", "recipe[ingredients_attributes][#{idx}][#{attr}]"
        end
        assert_select "input#recipe_ingredients_attributes_#{idx}_id[value=?]", id.to_s
      end
      assert_select "a[data-association=?][data-target=?]", 'ingredients', '#ingredients'
      assert_select "textarea#recipe_directions[name=?]", "recipe[directions]"
    end
  end
  
  protected

  def stub_recipe
    stub_model(Recipe, attributes_for(:recipe, id: '1'))
  end

  def stub_ingredient(id, recipe)
    stub_model(Ingredient, attributes_for(:ingredient, id: id, recipe_id: recipe.id))
  end
end
