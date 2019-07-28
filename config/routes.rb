Rails.application.routes.draw do

  get '/weather/:city', to: 'weather#forecast'

  root "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
