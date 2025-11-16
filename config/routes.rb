Rails.application.routes.draw do
  root "pages#home"
  
  get 'pages/home'
  get 'rooms', to: 'pages#rooms'
  get 'tours', to: 'pages#tours'
  get 'booking', to: 'pages#booking'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


    # Adiciona rota show para casas
    resources :casas, only: [:show]

    # Adiciona rota create para bookings
    resources :bookings, only: [:create]


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
