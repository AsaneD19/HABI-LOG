Rails.application.routes.draw do

  devise_for :members
  post "/guest_sign_in", to: "homes#guest_sign_in"
  get "/search", to: "searches#search"

  root to: "homes#top"
  get "/about", to: "homes#about"
  get "/home",  to: "feeds#index"
  resources :notifications, only: [:update, :show, :index]
  resources :members do
    resources :habits
    resource :follow_request, only: [:create, :update, :destroy]
    resource :relationship, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end
  resource :favorite, only: [:create, :destroy]
  resources :feeds, only: [:show, :destroy] do
    resource :favorite, only: [:create, :destroy, :index], defaults: { favoritable_type: 'Feed' }
    resources :post_comments, only: [:create, :destroy] do
      resource :favorite, only: [:create, :destroy, :index], defaults: { favoritable_type: 'PostComment' }
    end
  end
end
