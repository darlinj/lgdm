Lgdm::Application.routes.draw do
  match '/register', :to => "users#new"
  resources :servers, :only => [:index, :create]
  resources :images, :only => [:index]
  resources :users, :only => [:new, :create]
end
