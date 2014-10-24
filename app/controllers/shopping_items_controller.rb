class ShoppingItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_item, except: %i(index new create)
  before_action :set_items, only:  %i(index create update destroy toggle_active)

  respond_to :html, :js
  
  def index
  end

  def show
  end
  
  def new
    @item = @user.shopping_items.new
  end

  def create
    @item = @user.shopping_items.create(shopping_item_params)
  end

  def edit
  end

  def update
    @item.update_attributes(shopping_item_params)
  end

  def delete
  end

  def destroy
    @item.destroy
  end
  
  def toggle_active
    @item.toggle :active
    @item.save
  end

  private

  def set_user
    @user = current_user
  end

  def set_item
    @item = ShoppingItem.find(params[:id])
  end

  def set_items
    @items = @user.shopping_items
  end
  
  def shopping_item_params
    params.require(:shopping_item).permit(:name, :active, :id)
  end
end
