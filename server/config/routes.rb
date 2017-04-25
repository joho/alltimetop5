Rails.application.routes.draw do
  resources :graphql, only: [:index, :create]
end
