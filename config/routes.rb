Badge::Application.routes.draw do
  get "hub/index"

  match '/signup',  :to => 'users#new'
  match '/logout',  :to => "sessions#destroy"
  match '/signin',  :to =>"sessions#new"
  match '/media(/:dragonfly)', :to => Dragonfly[:images]
  
  root :to => "hub#index"
  
  resources :users  
  resources :awards
  resources :sessions, :only => [:new, :create, :destroy]
end
