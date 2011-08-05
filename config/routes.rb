Lgdm::Application.routes.draw do
  match '/login', :to => "sessions#new"
  match '/register', :to => "users#new"
  match '/activate', :to => "users#update"
  resource :session, :only => [:new, :create, :destroy]
  resources :servers, :only => [:index, :create]
  resources :images, :only => [:index]
  resources :users, :only => [:new, :create]
  resources :cloud_accounts, :only => [:index]
  root :to => "pages#home"
end
