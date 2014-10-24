Rails.application.routes.draw do

  devise_for :users, :path => "accounts"
  resources :shopping_items, except: %i(index) do
    get 'delete', on: :member
    get 'toggle_active', on: :member
  end
  get '/shopping_list', to: 'shopping_items#index'
    
  get 'recipes/pre_new' => 'recipes#pre_new', as: 'pre_new_recipe'
  resources :recipes

  root 'recipes#index'
end
