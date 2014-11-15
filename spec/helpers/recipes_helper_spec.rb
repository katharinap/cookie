require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RecipesHelper. For example:
#
# describe RecipesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RecipesHelper, :type => :helper do
  include Devise::TestHelpers

  describe '.allow_edit?' do
    context 'user is signed in' do

      before(:each) do
        @user = stub_model(User, attributes_for(:user, id: 1))
        allow(helper).to receive(:current_user) { @user }
      end
      
      it 'returns true if the recipe belongs to the current user' do
        recipe = stub_model(Recipe, attributes_for(:recipe, user_id: 1))
        expect(helper.allow_edit? recipe).to be_truthy
      end

      it 'returns false if the recipe does not belong to the current user' do
        recipe = stub_model(Recipe, attributes_for(:recipe, user_id: 2))
        expect(helper.allow_edit? recipe).to be_falsey
      end

      it 'returns false if the recipe does not belong to any user' do
        recipe = stub_model(Recipe, attributes_for(:recipe, user_id: nil))
        expect(helper.allow_edit? recipe).to be_falsey
      end
    end

    context 'user is not signed in' do
      it 'returns false' do
        recipe = stub_model(Recipe, attributes_for(:recipe, user_id: 1))
        allow(helper).to receive(:current_user) { nil }
        expect(helper.allow_edit? recipe).to be_falsey
      end
    end
  end
end
