require 'rails_helper'

RSpec.describe "recipes/new", :type => :view do
  before(:each) do
    recipe = stub_recipe
    assign :recipe, recipe
    allow(recipe).to receive(:ingredients).and_return([stub_ingredient])
  end

  it "renders new recipe form" do
    render
    assert_select "form[action=?][method=?]", recipes_path, "post" do
      assert_select "input#recipe_name[name=?]", "recipe[name]"
      %i(value _destroy).each do |attr|
        assert_select "input#recipe_ingredients_attributes_0_#{attr}[name=?]", "recipe[ingredients_attributes][0][#{attr}]"
      end
      assert_select "a[data-association=?][data-target=?]", 'ingredients', '#ingredients'
      assert_select "textarea#recipe_directions[name=?]", "recipe[directions]"
      assert_select "a[data-association=?]", 'references'
    end
  end
  
  protected

  def stub_recipe
    stub_model(Recipe).as_new_record
  end

  def stub_ingredient
    stub_model(Ingredient).as_new_record
  end
end
