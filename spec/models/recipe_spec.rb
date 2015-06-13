# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string
#  user_id    :integer
#  component  :boolean          default("false")
#

require 'rails_helper'

RSpec.describe Recipe, :type => :model do
  describe "validation" do
    it "is not valid without a name" do
      expect(build(:recipe, name: nil)).not_to be_valid
    end

    it "is not valid with a blank name" do
      expect(build(:recipe, name: "")).not_to be_valid
    end

    it "is valid with a non-empty name" do
      expect(build(:recipe, name: "my validation recipe")).to be_valid
    end
  end

  describe '.picture' do
    it_behaves_like "with picture", :recipe, { default: [400, 400], thumb: [50, 50] }
  end

  describe '.user_name' do
    it 'returns the user name' do
      user = create(:user)
      expect(build(:recipe, user_id: user.id).user_name).to eq(user.name)
    end

    it 'returns N/A if no user is assigned' do
      expect(build(:recipe, user_id: nil).user_name).to eq('N/A')
    end
  end

  describe '.components' do
    it 'returns the components of a recipe with sub-recipes' do
      components = create_list(:recipe, 3)
      recipe = create(:recipe)
      components.each { |component| recipe.recipe_components.create(component_id: component.id) }
      expect(recipe.components(true).count).to eq(3)
    end

    it 'returns an empty array for normal recipes' do
      expect(create(:recipe).components).to be_empty
    end
  end

  describe '.component?' do
    it 'is false by default' do
      expect(build(:recipe)).not_to be_component
    end

    it 'returns true if component is set to true' do
      expect(build(:recipe, component: true)).to be_component
    end

    it 'returns false if component is set to false' do
      expect(build(:recipe, component: false)).not_to be_component
    end
  end

  describe '.prepare_recipe' do
    it 'sets the basic attribute with cleaned-up values' do
      params = { name: 'abc ', user_id: 27, component: true }
      recipe = Recipe.new.prepare_recipe(params)
      expect(recipe.name).to eq('abc')
      expect(recipe.user_id).to eq(27)
      expect(recipe.component).to be_truthy
    end

    it 'sets the ingredients' do
      params = { ingredients: "something good\n\nsomething else ", steps: ' ' }
      recipe = Recipe.new.prepare_recipe(params)
      expect(recipe.ingredients.size).to eq(2)
      expect(recipe.ingredients.first.value).to eq('something good')
      expect(recipe.ingredients.last.value).to eq('something else')
      expect(recipe.steps).to be_empty
      expect(recipe.references).to be_empty
    end

    it 'sets the steps' do
      params = { steps: 'do something good' }
      recipe = Recipe.new.prepare_recipe(params)
      expect(recipe.steps.size).to eq(1)
      expect(recipe.steps.first.description).to eq('do something good')
    end

    it 'sets the references' do
      params = { references: 'http://www.example.com' }
      recipe = Recipe.new.prepare_recipe(params)
      expect(recipe.references.size).to eq(1)
      expect(recipe.references.first.url).to eq('http://www.example.com')
    end
  end
end
