Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#index'
  get '/shop/categories', to: 'shop#categories'
  get '/shop/categories/:category_id/products', to: 'shop#category_products'
  get '/shop/products/:product_id/specs', to: 'shop#product_details'
end

