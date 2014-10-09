# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string
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
    it_behaves_like "with picture", :recipe, { default: [800, 800], thumb: [50, 50] }
  end
end
