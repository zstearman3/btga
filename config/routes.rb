Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # DASHBOARDS
  root "dashboards#countdown"
  get '/dashboard', to: 'dashboards#main'

  resources :courses, except: :show 
  resources :tournaments, except: :destroy 
end
