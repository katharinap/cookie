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

  # we don't want to create the same item more than once.  if we
  # already have this item, we rather want to set it to active
  def create
    @item = @user.shopping_items.find_by(name: shopping_item_params[:name])
    if @item
      @item.update(active: true)
    else
      @item = @user.shopping_items.create(shopping_item_params)
    end
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

  # sorting: list active items first
  def set_items
    @items = @user.shopping_items.sort_by { |item| item.active ? 0 : 1 }
  end
  
  def shopping_item_params
    params.require(:shopping_item).permit(:name, :active, :id)
  end
end
