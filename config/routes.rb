Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations'
  }
  resources :profiles do
    resources :projects
    resource :follow, only: [:create, :destroy]
  end

  root to: 'profiles#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
