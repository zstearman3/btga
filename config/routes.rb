Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # DASHBOARDS
  root "dashboards#main"
  get '/dashboard', to: 'dashboards#main'
  get '/seasons/:year/schedule', to: 'seasons#schedule'

  resources :courses, except: :show 
  resources :tournaments
  resources :events
  resources :golfer_events, only: [:new, :create]
end
