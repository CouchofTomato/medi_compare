Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'

  resources :benefits
  resources :insurers do
    resources :products
  end

  resources :products do
    resources :product_modules
  end

  resources :product_modules
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
