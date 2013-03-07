OneTeam::Application.routes.draw do

  resources :request_skills


  resources :create_request_skills


  resources :desired_skills


  resources :current_skills


  resources :positions


  resources :groups


  resources :departments


  resources :locations


  resources :offices


  resources :skills


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

  resources :responses, :shallow => true do
    resources :selections
  end

#I think I originally had redundant routes here, have commented out for now.
  #resources :responses
  resources :employees
  #resources :selections 
  resources :sessions, only: [:new, :create, :destroy]

end
