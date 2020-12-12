Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json }  do 
    namespace :v1 do 
      resources :pokemons, only: [:index, :show, :create, :update, :destroy]
    end
  end

  resources :pokemons
end
