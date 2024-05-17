Rails.application.routes.draw do

  devise_for :members
  post "/guest_sign_in", to: "homes#guest_sign_in"

  root to: "homes#top"
  get "/about", to: "homes#about"
  get "/home",  to: "feeds#index"

  resources :members do
    collection do
      get 'search'
    end
    resources :habits
    resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end

  resources :feeds, only: [:show, :destroy] do
    resources :post_comments
    resource :favorites, only: [:create, :destroy]
  end

end
