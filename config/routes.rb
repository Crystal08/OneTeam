OneTeam::Application.routes.draw do

  resources :requests do
    resources :responses
  end

  resources :employees

  resources :requests

  resources :responses

end
