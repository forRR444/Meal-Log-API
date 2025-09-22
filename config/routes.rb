Rails.application.routes.draw do
  post "/api/signup", to: "users#create"
  namespace :api, defaults: { format: :json } do
    post 'login', to: 'sessions#create'
    get  'me',    to: 'me#show'
    resources :meals, only: [:index, :show, :create, :update, :destroy]
  end
end
