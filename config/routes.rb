Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "pages#home"

  get "events/map", to: "events#map"
  get "spots/map", to: "spots#map"

  resources :events  do
    resources :participations, only: :create
    resources :reviews, only: :create
  end

  resource :profile, only: %i[show edit update]

  resources :my_events, only: :index
  post "events/:id/duplicate", to: "events#duplicate"
  resources :itineratie, only: :create
  resources :places, only: :index
  resources :spots, only: %i[index show]
end
