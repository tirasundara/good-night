Rails.application.routes.draw do
  # /ping end-point for health-check
  get "/ping", to: "ping#ping"
end
