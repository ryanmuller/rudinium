Rudini::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root :to => "items#index"
  resources :items, :only => :index
  resources :spaceable_memories, :only => [:create, :index, :show, :update]
  resources :lectures, :only => [:index, :show]
end
