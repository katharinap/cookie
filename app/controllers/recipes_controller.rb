#
class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
    respond_to do |format|
      format.html {}
      format.json { render json: @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/new
  def new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = new_recipe

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        @render_final_form = true
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.includes(:ingredients, :references, :components).find(params[:id])
  end

  def new_recipe
    if new_params.empty?
      # after re-display of new, with final form
      Recipe.new(recipe_params)
    else
      Recipe.new.prepare_recipe(new_params)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:recipe).permit(
      :name,
      :user_id,
      :component,
      :picture,
      :remove_picture,
      :picture_cache,
      ingredients_attributes: [:id, :value, :_destroy],
      steps_attributes: [:id, :description, :picture, :remove_picture, :picture_cache, :_destroy],
      references_attributes: [:id, :url, :_destroy], component_ids: []
    )
  end

  def new_params
    params.permit(:name, :user_id, :component, :ingredients, :steps, :references)
  end
end
