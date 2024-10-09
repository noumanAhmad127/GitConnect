Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations'
  }
  resources :profiles do
    resources :projects
    resource :follow, only: %i[create destroy]
    member do
      get 'followers'
      get 'following'
    end

    resources :posts, only: %i[new create edit update destroy]
  end
  # resources :likes, only: %i[create destroy]
  resources :posts, only: %i[index show] do
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :comments
    end
  end

  get 'tags/:tag', to: 'posts#index', as: :tag

  root to: 'profiles#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
