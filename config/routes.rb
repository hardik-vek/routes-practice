Rails.application.routes.draw do
  resources :users, as: "hardik"
  resource :customers, only: [:show, :update]
  resource :orders, except: [:destroy]
  resources :brands, only: [:index] do
    resources :products, only: [:show, :edit]
  end
  resource :geocoder
  # resolve('Geocoder') { [:geocoder] }
  draw(:admin)
  scope module: "admin" do
    resources :comments
  end
  resources :offices, as: "shubham"
  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/patients/:id", to: "patients#show"
  resources :hello, shallow: true do
    resources :abc
  end

  concern :commentable do
    resources :comments
  end

  resources :photos do # if you required an id then use member
    member do
      get "preview"
    end
  end

  resources :photos do # if you don't required an id then use collection
    collection do
      get "search"
    end
  end

  get "photos/:id", to: "photos#show", defaults: { format: "jpg" }
  get "logout", to: "sessions#destroy", as: :logout
  get "photos/*other", to: "photos#unknown"
  # Defines the root path route ("/")
  # root "articles#index"
end
