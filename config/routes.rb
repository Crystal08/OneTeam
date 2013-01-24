OneTeam::Application.routes.draw do

  root :to => 'requests#index'
  
#The :as => part below names the route, so that employee_requests_path returns /employees/:employee_id/requests; See _header.html.erb with link_to for "My Requests" 
#Reference: http://guides.rubyonrails.org/routing.html Section 3.6 "Naming Routes"
  match '/employees/:employee_id/requests' => 'requests#index', :as => :employee_requests
#  match '/responses/:response_id/selections/new' => 'selections#new', :as => :response_selection NOT NEEDED ONCE I NESTED SELECTION W/IN RESPONSES, BELOW
  match '/signup', to: 'employees#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  resources :requests do
    resources :responses
  end

  resources :responses do
    resources :selections
  end

#I think I have redundant routes here. May want to think about user-intuitive routes and come back to clean up.
  resources :responses
  resources :employees
  resources :selections 
  resources :sessions, only: [:new, :create, :destroy]

end
