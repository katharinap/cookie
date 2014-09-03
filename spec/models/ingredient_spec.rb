# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  name       :string
#  amount     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  notes      :string
#

require 'rails_helper'

RSpec.describe Ingredient, :type => :model do
  describe ".has_notes?" do
    it "returns false if notes is nil" do
      expect(create(:ingredient, notes: nil)).not_to have_notes
    end

    it "returns false if notes only contain whitespace" do
      expect(create(:ingredient, notes: "\t ")).not_to have_notes
    end

    it "returns true if there are any notes" do
      expect(create(:ingredient, notes: "something notable...\t ")).to have_notes
    end
  end

  describe ".strip_whitespace" do
    it "removes leading whitespace" do
      name = 'seitan'
      ingredient = create(:ingredient, name: "  #{name}")
      expect(ingredient.name).to eq(name)
    end

    it "removes trailing whitespace" do
      amount = '1 cup'
      ingredient = create(:ingredient, amount: "#{amount}\t")
      expect(ingredient.amount).to eq(amount)
    end
  end
end
