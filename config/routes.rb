Lgdm::Application.routes.draw do
  resources :servers, :only => [:index, :create]
  resources :images, :only => [:index]
end
