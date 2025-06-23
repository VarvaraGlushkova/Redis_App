Rails.application.routes.draw do
  devise_for :users

  resources :themes
  resources :posts, only: [:index, :show]
  resources :subscriptions
  resources :profiles

  resources :users do
    resources :comments
    resources :profiles, only: [:new, :create, :show, :edit, :update]
  end

  resources :themes do
    resources :tasks
  end

  resources :posts do
    resources :tasks
  end


  resources :tasks do
    resources :answers

    member do
      post 'like', to: 'likes#create'
      delete 'unlike', to: 'likes#destroy'
    end
  end

  resources :answers do
    resources :comments

    resources :likes, only: [:index, :show, :create, :update, :destroy]

    member do
      post 'like', to: 'likes#create'
      delete 'unlike', to: 'likes#destroy'
    end

  end

  # LOGIN AND AUTHORISE


  # API V1 version, fixing process
  namespace :api, format: "json" do
    namespace :v1 do
      resources :answers, only: [ :index, :show ]
      resources :themes, only: [ :index, :show ]
      resources :tasks, only: [ :index, :show ]
      resources :profiles, only: [ :show ]
      resources :users, only: [:index, :show]

      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "sign_out", to: "sessions#destroy"
      end


      resources :answers, only: [:show] do
        resources :comments, only: [:index, :show, :create, :update, :destroy]
        resources :likes, only: [:index, :show, :create, :update, :destroy]

        member do
          post 'like', to: 'likes#create'
          delete 'unlike', to: 'likes#destroy'
        end
    
      end



    end
  end

  # Тут пастроим админский неймспейс, маме Максима привет

  # Admin namespace
  namespace :admin do
    resources :themes, except: [ :index, :show ] do
      resources :tasks
    end
    resources :tasks, except: [ :index, :show ] do
      resources :answers
    end
    resources :answers, except: [ :index, :show ] do
      resources :comments
    end

    resources :posts

  end








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
