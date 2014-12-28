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

  describe '.components', focus: true do
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
end
