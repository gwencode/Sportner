Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "pages#home"

  get "events/map", to: "events#map"
  get "spots/map", to: "spots#map"

  resources :events do
    resources :participations, only: :create
    resources :reviews, only: :create
  end

  resource :profile, only: %i[show edit update]
  resources :run_details, only: %i[new create]

  resources :my_events, only: :index
  post "events/:id/duplicate", to: "events#duplicate"
  resources :itineratie, only: :create
  resources :places, only: :index
  resources :spots, only: %i[index show] do
    resources :my_spots, only: :create
  end

  resources :chatrooms, only: %i[create index show] do
    resources :messages, only: :create
  end

  resources :my_spots, only: :index
end
