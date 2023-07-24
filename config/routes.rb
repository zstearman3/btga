Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboards#countdown"

  resources :courses, except: :show 

  get '/dashboard', to: 'dashboards#main'
end
