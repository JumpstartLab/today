Today::Application.routes.draw do

  # resources :programs do
  #   resources :sessions do
  #     resources :outline
  #   end
  # end

  resources :outlines

  root to: "schedule#show"

  get "/:id", to: "schedule#show", as: "schedule"

end
