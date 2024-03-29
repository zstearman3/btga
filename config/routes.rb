Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # DASHBOARDS
  root "dashboards#main"
  get '/dashboard', to: 'dashboards#main'
  get '/seasons/:year/schedule', to: 'seasons#schedule'

  resources :courses, except: :show 
  resources :tournaments
  resources :golfer_events, except: [:show]

  resources :events do
    post 'finalize', on: :member
    post 'unfinalize', on: :member
  end
end
