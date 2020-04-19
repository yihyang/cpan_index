Rails.application.routes.draw do
  get 'packages/search', to: 'packages#search'
  resources :packages, only: [:index, :show]
  get 'person/search', to: 'person#search'
  resources :person, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get 'search', to: 'home#search'
end
