Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :users, only: [:index, :show] do
    resources :groups, only: [:index, :show, :new, :create, :destroy] do
      resources :expenses, only: [:index, :show, :new, :create, :destroy] do
          resources :expense_groups, only: [:new, :create, :destroy]
       end
    end
  end
  get '/splash', to: 'groups#splash', as: 'splash'

  authenticated :user do
    root 'groups#index', as: :authenticated_root
  end

  unauthenticated do
    root 'groups#splash', as: :unauthenticated_root
  end
end
