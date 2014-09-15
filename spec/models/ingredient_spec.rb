# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  value      :string
#

require 'rails_helper'

RSpec.describe Ingredient, :type => :model do
  describe ".strip_whitespace" do
    it "removes leading whitespace" do
      value = 'seitan'
      ingredient = create(:ingredient, value: "  #{value}")
      expect(ingredient.value).to eq(value)
    end

    it "removes trailing whitespace" do
      value = '1 cup something'
      ingredient = create(:ingredient, value: "#{value}\t")
      expect(ingredient.value).to eq(value)
    end
  end
end
