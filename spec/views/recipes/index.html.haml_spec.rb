require 'rails_helper'

RSpec.describe "recipes/index", :type => :view do
  before(:each) do
    allow(view).to receive(:user_signed_in?) { true }
    allow(view).to receive(:current_user).and_return(stub_model(User))
  end
  
  it "renders a list of recipes" do
    assign(:recipes, (1..5).map{ |i| stub_recipe(i) })
    render
    (1..5).each do |i|
      assert_select "tr>td>a[href=?]", recipe_path(i), text: "#{i.ordinalize} Recipe", count: 1
    end
    assert_select "a[href=?]", pre_new_recipe_path
  end

  it "displays the user name" do
    user = create(:user, name: 'foo')
    recipe = stub_recipe(38, user_id: user.id)
    assign(:recipes, [recipe])
    render
    expect(rendered).to match /foo/
  end


  it "displays N/A if the recipe does not belong to anybody" do
    recipe = stub_recipe(38)
    recipe.user = nil
    assign(:recipes, [recipe])
    render
    expect(rendered).to match /N\/A/
  end

  it "enables the edit and delete button if the current user is allowed to edit a recipe" do
    allow(view).to receive(:allow_edit?).and_return(true)
    recipe = stub_recipe(38)
    assign(:recipes, [recipe])
    render
    expect(rendered).to have_selector("a[href='#{edit_recipe_path(38)}']", count: 1)
    expect(rendered).to have_selector("a[href='#{recipe_path(38)}'][data-method='delete']", count: 1)
  end
  
  it "disables the edit and delete button if the current user is not allowed to edit a recipe" do
    allow(view).to receive(:allow_edit?).and_return(false)
    recipe = stub_recipe(38)
    assign(:recipes, [recipe])
    render
    expect(rendered).to have_selector("a[href='#{edit_recipe_path(38)}']", count: 0)
    expect(rendered).to have_selector("a[href='#{recipe_path(38)}'][data-method='delete']", count: 0)
    expect(rendered).to have_selector("a[href='#'][disabled='disabled']", count: 2)
  end
  
  protected

  def stub_recipe(id, user_id: nil)
    stub_model(Recipe, attributes_for(:recipe, id: id.to_s, name: "#{id.ordinalize} Recipe", created_at: Time.now, user_id: user_id || stub_model(User, attributes_for(:user)).id))
  end
end
