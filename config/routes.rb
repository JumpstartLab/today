Today::Application.routes.draw do

  resources :outlines

  root to: "schedule#show"

  get "/:date_string", to: "schedule#show", as: "schedule"

end
