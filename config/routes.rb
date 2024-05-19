Rails.application.routes.draw do

  devise_for :members
  post "/guest_sign_in", to: "homes#guest_sign_in"
  get "/search", to: "searches#search"

  root to: "homes#top"
  get "/about", to: "homes#about"
  get "/home",  to: "feeds#index"

  resources :members do
    resources :habits
    resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end
  resources :favorites, only: [:create, :destroy]
  resources :feeds, only: [:show, :destroy] do
    resources :favorites, only: [:create, :destroy], defaults: { favoritable_type: 'Feed' }
    resources :post_comments, only: [:create, :destroy] do
      resources :favorites, only: [:create, :destroy], defaults: { favoritable_type: 'PostComment' }
    end
  end

  resources :notifications, only: [:update]
end
