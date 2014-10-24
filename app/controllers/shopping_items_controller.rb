class ShoppingItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  respond_to :html, :js
  
  def index
    @items = @user.shopping_items
  end

  def show
    @item = ShoppingItem.find(params[:id])
  end
  
  def new
    @item = @user.shopping_items.new
  end

  def create
    @item = @user.shopping_items.create(shopping_item_params)
    @items = @user.shopping_items
  end

  def edit
    @item = ShoppingItem.find(params[:id])
  end

  def update
    @item = ShoppingItem.find(params[:id])
    @items = @user.shopping_items
    @item.update_attributes(shopping_item_params)
  end

  def delete
    @item = ShoppingItem.find(params[:shopping_item_id])
  end

  def destroy
    @item = ShoppingItem.find(params[:id])
    @items = @user.shopping_items
    @item.destroy
  end
  
  private

  def set_user
    @user = current_user
  end
  
  def shopping_item_params
    params.require(:shopping_item).permit(:name, :id)
  end
end
