Badge::Application.routes.draw do

  match '/signup',  :to => 'users#new'
  match '/logout',  :to => "sessions#destroy"
  match '/signin',  :to => "sessions#new"
  match '/media(/:dragonfly)', :to => Dragonfly[:images]
  post '/email_badge', :to => "awards#email_badge"
  
  
  root :to => "sessions#new"
  
  resources :users  
  resources :awards
  resources :sessions, :only => [:new, :create, :destroy]
end
