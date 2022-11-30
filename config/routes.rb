Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "events/map", to: "events#map"

  resources :events  do
    resources :participation, only: :create
    resources :reviews, only: :create

  end

  resources :profiles, only: %i[edit update]
  resources :my_events, only: :index
  post "events/:id/duplicate", to: "events#duplicate"
  resources :itineratie, only: :create
  resource :places, only: :index
end
