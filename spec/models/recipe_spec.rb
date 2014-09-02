# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  directions :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
end
