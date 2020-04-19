Rails.application.routes.draw do
  get 'packages', to: 'packages#index'
  get 'packages/search', to: 'packages#search'
  get 'packages/:id', to: 'packages#show'
  get 'person', to: 'person#index'
  get 'person/search', to: 'person#search'
  get 'person/:id', to: 'person#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get 'search', to: 'home#search'
end
