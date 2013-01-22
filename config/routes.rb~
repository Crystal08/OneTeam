OneTeam::Application.routes.draw do

  root :to => 'requests#index'
  
#The :as => part below names the route, so that employee_requests_path returns /employees/:employee_id/requests; See _header.html.erb with link_to for "My Requests" 
#Reference: http://guides.rubyonrails.org/routing.html Section 3.6 "Naming Routes"
  match '/employees/:employee_id/requests' => 'requests#index', :as => :employee_requests
  match '/responses/:response_id/selected_employees/new' => 'selected_employees#new', :as => :response_selected_employee
  match '/signup', to: 'employees#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  resources :requests do
    resources :responses
  end

  resources :responses
  resources :employees
  resources :selected_employees
  resources :sessions, only: [:new, :create, :destroy]

end
