Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#index'
  get '/shop/categories', to: 'shop#categories'
  get '/shop/categories/:category_id/products', to: 'shop#category_products'
  get '/shop/products/:product_id/specs', to: 'shop#product_details'
  get '/shop/products/:product_id/factory_model', to: 'shop#factory_model'
  get '/shop/products/:product_id/option/:option_name/choices', to: 'shop#product_choices'

  namespace :admin do
    resources :product_types, path: 'categories' do
      resources :products do
        resources :product_choice_lines, path: 'choices'
      end
      resources :customization_types, path: 'options' do
        resources :customization_choices, path: 'choices'
      end
    end
  end
end
