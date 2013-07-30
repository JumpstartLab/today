Today::Application.routes.draw do

  # resources :programs do
  #   resources :sessions do
  #     resources :outline
  #   end
  # end

  root to: "outlines#today"

end
