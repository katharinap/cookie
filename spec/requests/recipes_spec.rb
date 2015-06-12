require 'rails_helper'

RSpec.describe "Recipes", :type => :request do
  describe "GET /recipes" do
    it "renders the index view" do
      get recipes_path
      # expect(response.status).to be(200)
      expect(response).to render_template(:index)
    end
  end
end
