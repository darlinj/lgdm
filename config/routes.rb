Lgdm::Application.routes.draw do
  match '/login', :to => "sessions#new"
  match '/logout', :to => "sessions#destroy"
  match '/register', :to => "users#new"
  match '/activate', :to => "users#update"
  resource :session, :only => [:create]
  resources :servers, :only => [:index, :create]
  resources :images, :only => [:index]
  resources :users, :only => [:new, :create]
  resources :cloud_accounts, :only => [:index,:new, :create]
  resources :chef_api_accounts, :only => [:index, :new, :create]
  root :to => "pages#home"
end
