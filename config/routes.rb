Rails.application.routes.draw do
  devise_for :users

  resources :themes
  resources :posts
  resources :subscriptions

  resources :tasks do
    resources :answers
  end

  resources :answers do
    resources :comments
  end

  # LOGIN AND AUTHORISE


  # API V1 version, fixing process
  namespace :api, format: "json" do
    namespace :v1 do
      resources :tasks, only: [ :index, :show ]
      resources :answers, only: [ :index, :show ]
    end
  end

  # Тут пастроим админский неймспейс, маме Максима привет








  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "welcome#index"
end
