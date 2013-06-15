OneTeam::Application.routes.draw do

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

  match '/signup', to: 'employees#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
 
  match '/dashboards/requests_overview' => 'dashboards#requests_overview', :as => :dashboard_requests_overview
  match '/dashboards/skills_overview' => 'dashboards#skills_overview', :as => :dashboard_skills_overview
  match '/dashboards/guest_developers_overview' => 'dashboards#guest_developers_overview', :as => :dashboard_guest_developers_overview

  resources :requests do
    resources :responses
  end

  resources :responses, :shallow => true do
    resources :selections
  end

  resources :responses do
    resources :evaluations
  end  

#I think I originally had redundant routes here, have commented out for now.
  #resources :responses
  resources :employees
  #resources :selections 
  resources :sessions, only: [:new, :create, :destroy]
#I think don't need the below, just the custom routes above  
  #resources :dashboards
end
