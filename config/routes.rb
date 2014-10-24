Rails.application.routes.draw do

  devise_for :users, :path => "accounts"
  resources :users, only: [] do
    resources :shopping_items, shallow: true, except: %i(index) do
      get 'delete'
    end
  end
  get '/users/:user_id/shopping_list', to: 'shopping_items#index'
    
  get 'recipes/pre_new' => 'recipes#pre_new', as: 'pre_new_recipe'
  resources :recipes

  root 'recipes#index'
end
