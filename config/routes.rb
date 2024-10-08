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
  resources :posts, only: %i[index show]
  root to: 'profiles#index'

  get 'tags/:tag', to: 'posts#index', as: :tag
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
