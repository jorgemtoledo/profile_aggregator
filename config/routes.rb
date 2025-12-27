Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  resources :profiles do
    post :rescan, on: :member 
  end

  get "/s/:code", to: "short_urls#redirect", as: :short_url
end
