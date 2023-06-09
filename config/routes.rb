Rails.application.routes.draw do

  # /ping end-point for health-check
  get "/ping", to: "ping#ping"

  namespace :api do
    namespace :v1 do
      resources :user_follows, only: :create
      delete "/user_follows/:followee_id", to: "user_follows#destroy"

      resources :sleep_times, only: [:index, :create]
      resources :wake_up_times, only: :create
      resources :sleep_records, only: :index
    end
  end
end
