# == Schema Information
#
# Table name: steps
#
#  id          :integer          not null, primary key
#  recipe_id   :integer
#  idx         :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  picture     :string
#

require 'rails_helper'

RSpec.describe Step, :type => :model do
  describe 'validations' do
    it 'is not valid without a description' do
      expect(build :step, description: nil).to be_invalid
    end

    it 'is not valid without an empty description' do
      expect(build :step, description: '').to be_invalid
    end

    it 'is not valid with a description that only contains whitespace' do
      expect(build :step, description: "\t\n").to be_invalid
    end

    it 'is valid with a non-empty description' do
      expect(build :step, description: 'do something').to be_valid
    end

    it 'is valid with a unique index' do
      pending('not implemented yet')
      not_implemented_yet
      # recipe = create(:recipe)
      # create :step, recipe_id: recipe.id, idx: 27
      # expect(build :step, recipe_id: recipe.id, idx: 42).to be_valid
    end

    it 'is not valid without an index' do
      pending('not implemented yet')
      expect(build :step, idx: nil).to be_invalid
    end

    it 'is not valid with an non-unique index' do
      pending('not implemented yet')
      recipe = create(:recipe)
      step_attr = { recipe_id: recipe.id, step: 27 }
      create :step, step_attr
      expect(build :step, step_attr).to be_invalid
    end
  end
end
