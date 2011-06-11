Lgdm::Application.routes.draw do
  resources :servers, :only => [:index]
  resources :images, :only => [:index]
end
