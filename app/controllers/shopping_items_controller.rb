class ShoppingItemsController < ApplicationController
  respond_to :html, :js
  before_action :set_user, only: %i(index create new)
  before_action :set_user, only: %i(index create)
  
  def index
    @items = @user.shopping_items
  end

  def show
    @item = ShoppingItem.find(params[:id])
  end
  
  def new
    @user = User.find(params[:user_id])
    @item = @user.shopping_items.new
  end

  def create
    @user = User.find(params[:user_id])
    @item = @user.shopping_items.create(shopping_item_params)
    @items = @user.shopping_items
  end

  def edit
    @item = ShoppingItem.find(params[:id])
  end

  def update
    @item = ShoppingItem.find(params[:id])
    @user = @item.user
    @items = @user.shopping_items
    @item.update_attributes(shopping_items_params)
  end

  def delete
    @item = ShoppingItem.find(params[:shopping_item_id])
  end

  def destroy
    @item = ShoppingItem.find(params[:id])
    @user = @item.user
    @items = @user.shopping_items
    @item.destroy
  end
  
  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_items
    @items = @user.shopping_items
  end
  
  def shopping_items_nested_params
    params.require(:users).permit(shopping_items: [:name, :user_id, :id])
  end

  def shopping_item_params
    params.require(:shopping_item).permit(:name, :user_id, :id)
  end
end
