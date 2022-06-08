Rails.application.routes.draw do

  # get 'products', to:'products#index'
  # get 'products/new', to:'products#new', as: 'new_products'

  # get 'products/:id', to:'products#show', as: :product

  # get 'products/:id/edit', to:'products#edit', as: :edit_product
  # patch 'products/:id', to:'products#update'

  # post 'products', to: 'products#create'
  
  resources :products do
    get 'search', on: :collection # products/search -> products#seach
  end

  root "main#welcome"
end
