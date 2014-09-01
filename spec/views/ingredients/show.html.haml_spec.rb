require 'rails_helper'

RSpec.describe "ingredients/show", :type => :view do
  before(:each) do
    @ingredient = assign(:ingredient, Ingredient.create!(
      :recipe_id => 1,
      :additive => "Additive",
      :amount => "Amount"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Additive/)
    expect(rendered).to match(/Amount/)
  end
end
