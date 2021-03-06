Rails.application.routes.draw do
  root to: 'items#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :toppages, only: [:index]
  
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :favorites
      get :reviews
    end
  end
  
  resources :items, only: [:index, :create] do
    collection do 
      get :fav_ranking
      get :rev_ranking
      get :search
    end
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  
  resources :favorites, only: [:create, :destroy]
end
