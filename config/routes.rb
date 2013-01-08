OneTeam::Application.routes.draw do

  resources :requests do
    resources :responses
  end

  resources :employees

  resources :requests

  resources :responses

  resources :sessions, only: [:new, :create, :destroy]

  root :to => 'requests#index'

  match '/signup', to: 'employees#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

end
