require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe RecipesController, :type => :controller do

  let(:invalid_attributes) {
    {name: ""}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RecipesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # creates and returns two ingredient records for the given recipe
  def create_ingredients(recipe, count: 2)
    (1..count).map{|i| create(:ingredient, recipe_id: recipe.id)}
  end

  describe "GET index" do
    it "assigns all recipes as @recipes" do
      recipe = create(:recipe)
      get :index, {}, valid_session
      expect(assigns(:recipes)).to eq([recipe])
    end
  end

  describe "GET show" do
    it "assigns the requested recipe as @recipe" do
      recipe = create(:recipe)
      ingredients = create_ingredients(recipe)
      get :show, {:id => recipe.to_param}, valid_session
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:recipe).ingredients).to eq(ingredients)
    end
  end

  describe "GET new" do
    it "assigns a new recipe as @recipe" do
      get :new, {}, valid_session
      expect(assigns(:recipe)).to be_a_new(Recipe)
    end
  end

  describe "GET edit" do
    it "assigns the requested recipe as @recipe" do
      recipe = create(:recipe)
      ingredients = create_ingredients(recipe)
      get :edit, {:id => recipe.to_param}, valid_session
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:recipe).ingredients).to eq(ingredients)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Recipe" do
        expect {
          post :create, {:recipe => attributes_for(:recipe)}, valid_session
        }.to change(Recipe, :count).by(1)
      end

      it "assigns a newly created recipe as @recipe" do
        ingredient_attributes = attributes_for(:ingredient)
        recipe_attributes = attributes_for(:recipe).merge({ ingredients_attributes: {'1' => ingredient_attributes}})
        post :create, {:recipe => recipe_attributes}, valid_session
        expect(assigns(:recipe)).to be_a(Recipe)
        expect(assigns(:recipe)).to be_persisted
      end

      it "assigns creates the ingredients" do
        recipe_attributes = attributes_for(:recipe).merge({ ingredients_attributes: {'1' => attributes_for(:ingredient), '2' => attributes_for(:ingredient) }})
        post :create, {:recipe => recipe_attributes}, valid_session
        ingredients = assigns(:recipe).ingredients
        expect(ingredients.count).to eq(2)
        expect(ingredients.first).to be_a(Ingredient)
        expect(ingredients.first).to be_persisted
      end

      it "redirects to the created recipe" do
        post :create, {:recipe => attributes_for(:recipe)}, valid_session
        expect(response).to redirect_to(Recipe.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recipe as @recipe" do
        post :create, {:recipe => invalid_attributes}, valid_session
        expect(assigns(:recipe)).to be_a_new(Recipe)
      end

      it "re-renders the 'new' template" do
        post :create, {:recipe => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: "New Recipe Name", directions: "lots of steps to follow..."}
      }
      
      it "updates the requested recipe" do
        recipe = create(:recipe)
        ingredient = create_ingredients(recipe, count: 1).first
        put :update, {:id => recipe.to_param, :recipe => new_attributes.merge({ingredients_attributes: {ingredient.id.to_s => {id: ingredient.id.to_s, value: "Tofu"}}})}, valid_session
        recipe.reload
        # recipe.ingredients.reload
        expect(assigns(:recipe).name).to eq(new_attributes[:name])
        expect(assigns(:recipe).directions).to eq(new_attributes[:directions])
        expect(assigns(:recipe).ingredients.first.value).to eq("Tofu")
      end

      it "assigns the requested recipe as @recipe" do
        recipe = create(:recipe)
        ingredient = create_ingredients(recipe, count: 1).first
        put :update, {:id => recipe.to_param, :recipe => new_attributes.merge({ingredients_attributes: {ingredient.id.to_s => {id: ingredient.id.to_s, value: "Tofu"}}})}, valid_session
        expect(assigns(:recipe)).to eq(recipe)
        expect(assigns(:recipe).ingredients.size).to eq(1)
      end

      it "redirects to the recipe" do
        recipe = create(:recipe)
        put :update, {:id => recipe.to_param, :recipe => attributes_for(:recipe)}, valid_session
        expect(response).to redirect_to(recipe)
      end
    end

    describe "with invalid params" do
      it "assigns the recipe as @recipe" do
        recipe = create(:recipe)
        put :update, {:id => recipe.to_param, :recipe => invalid_attributes}, valid_session
        expect(assigns(:recipe)).to eq(recipe)
      end

      it "re-renders the 'edit' template" do
        recipe = create(:recipe)
        put :update, {:id => recipe.to_param, :recipe => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested recipe" do
      recipe = create(:recipe)
      expect {
        delete :destroy, {:id => recipe.to_param}, valid_session
      }.to change(Recipe, :count).by(-1)
    end

    it "destroys the associated ingredients" do
      recipe = create(:recipe)
      create_ingredients(recipe)
      expect {
        delete :destroy, {:id => recipe.to_param}, valid_session
      }.to change(Ingredient, :count).by(-2)
    end

    it "redirects to the recipes list" do
      recipe = create(:recipe)
      delete :destroy, {:id => recipe.to_param}, valid_session
      expect(response).to redirect_to(recipes_url)
    end
  end

end
