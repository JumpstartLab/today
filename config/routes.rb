Today::Application.routes.draw do

  get '/please-login' => 'sessions#show', as: :please_login
  get '/login' => 'sessions#new', as: :login
  get '/github/callback' => 'sessions#callback', as: :github_callback
  delete '/logout' => 'sessions#destroy', as: :logout

  get "/search", to: "search#index", as: :search
  post "/search", to: "search#post", as: :search_for

  get "/:date_string", to: "schedule#show", as: "schedule"

  root to: "schedule#show"
  resources :outlines

end
