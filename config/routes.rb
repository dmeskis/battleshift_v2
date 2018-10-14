Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end

      resources :users, only: [:index, :show, :update]
    end
  end
  get '/', to: 'welcome#index'
  get '/dashboard', to: 'dashboard#index'
  resources :users, only: [:show, :index, :edit, :update, :create, :new]
  resources :account_activations, only: [:edit]
end
