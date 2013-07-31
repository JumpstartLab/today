Today::Application.routes.draw do

  # resources :programs do
  #   resources :sessions do
  #     resources :outline
  #   end
  # end

  resources :outlines

  root to: "outlines#today"

end
