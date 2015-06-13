require 'rails_helper'

RSpec.describe "recipes/new", :type => :view do
  before(:each) do
    recipe = stub_recipe
    assign :recipe, recipe
    allow(recipe).to receive(:ingredients).and_return([stub_ingredient])
    allow(recipe).to receive(:steps).and_return([stub_step])
    allow(view).to receive(:current_user).and_return(stub_model(User))
  end

  it "renders pre recipe form" do
    render
    assert_select "form[action=?][method=?]", recipes_path, "post" do
      assert_select "input#name[name=?]", "name"
      assert_select "textarea#ingredients[name=?]", "ingredients"
      assert_select "textarea#steps[name=?]", "steps"
    end
  end

  it "renders final recipe form" do
    assign :render_final_form, true
    render
    assert_select "form[action=?][method=?]", recipes_path, "post" do
      assert_select "input#recipe_name[name=?]", "recipe[name]"
      %i(value _destroy).each do |attr|
        assert_select "input#recipe_ingredients_attributes_0_#{attr}[name=?]", "recipe[ingredients_attributes][0][#{attr}]"
      end
      assert_select "a[data-association=?]", 'ingredients'
      %i(description _destroy).each do |attr|
        assert_select "#{attr==:description ? 'textarea' : 'input'}#recipe_steps_attributes_0_#{attr}[name=?]", "recipe[steps_attributes][0][#{attr}]"
      end
      assert_select "a[data-association=?]", 'steps'
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

  def stub_step
    stub_model(Step).as_new_record
  end
end
