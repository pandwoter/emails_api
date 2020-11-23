Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :campaigns,  only: [:create]
      resources :recipients, only: [:index, :show]
    end
  end
end
