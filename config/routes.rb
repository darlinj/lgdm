Lgdm::Application.routes.draw do
  match '/register', :to => "users#new"
  match '/activate', :to => "users#update"
  resources :servers, :only => [:index, :create]
  resources :images, :only => [:index]
  resources :users, :only => [:new, :create]
  root :to => "pages#home"
end
