Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :revenue do
        resources :merchants, only: [:index, :show]

        resources :items, only: [:index]
      end
      get "/merchants/find", to: 'merchants/search#index'
      get "/merchants/most_items", to: 'merchants/search#most_items'
      get "/items/find_all", to: 'items/search#index'

      resources :merchants, only: [:index, :show]

      resources :items, only: [:index, :show, :create, :update, :destroy]

      get "/merchants/:id/items", to: 'merchants_items#index'

      get "/items/:id/merchant", to: 'items_merchant#index'

    end
  end
end
