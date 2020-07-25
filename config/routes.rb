Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :trabalhos, only: %i[index]
      resources :trabalho, only: %i[create show update destroy], controller: :trabalhos
    end
  end
end
