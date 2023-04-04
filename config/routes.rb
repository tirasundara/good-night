Rails.application.routes.draw do

  # /ping end-point for health-check
  get "/ping", to: "ping#ping"

  namespace :api do
    namespace :v1 do
      resources :user_follows, only: :create
    end
  end
end
