Lgdm::Application.routes.draw do
  resources :servers, :only => [:index]
end
