require 'rails_helper'

RSpec.describe "recipes/edit", :type => :view do
  before(:each) do
    recipe = stub_recipe
    assign :recipe, recipe
    allow(recipe).to receive(:ingredients).and_return([stub_ingredient('1', recipe), stub_ingredient('2', recipe)])
    allow(recipe).to receive(:steps).and_return([stub_step('1', recipe), stub_step('2', recipe)])
    allow(view).to receive(:current_user).and_return(stub_model(User))
  end
    
  it "renders the edit recipe form" do
    render
    assert_select "form[action=?][method=?]", recipe_path('1'), "post" do
      assert_select "input#recipe_name[name=?]", "recipe[name]"
      [1,2].each_with_index do |id, idx|
        %i(value id _destroy).each do |attr|
          assert_select "input#recipe_ingredients_attributes_#{idx}_#{attr}[name=?]", "recipe[ingredients_attributes][#{idx}][#{attr}]"
        end
        assert_select "input#recipe_ingredients_attributes_#{idx}_id[value=?]", id.to_s
        %i(description idx id _destroy).each do |attr|
          assert_select "#{attr==:description ? 'textarea' : 'input'}#recipe_steps_attributes_#{idx}_#{attr}[name=?]", "recipe[steps_attributes][#{idx}][#{attr}]"
        end
        assert_select "input#recipe_steps_attributes_#{idx}_id[value=?]", id.to_s
      end
      assert_select "a[data-association=?]", 'ingredients'
    end
  end
  
  protected

  def stub_recipe
    stub_model(Recipe, attributes_for(:recipe, id: '1'))
  end

  def stub_ingredient(id, recipe)
    stub_model(Ingredient, attributes_for(:ingredient, id: id, recipe_id: recipe.id))
  end

  def stub_step(id, recipe)
    stub_model(Step, attributes_for(:step, id: id, recipe_id: recipe.id))
  end
end
