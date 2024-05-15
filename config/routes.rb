Rails.application.routes.draw do

  devise_for :members
  post "/guest_sign_in", to: "homes#guest_sign_in"

  root to: "homes#top"
  get "/about", to: "homes#about", as: "about"
  get "/home",  to: "feeds#index", as: "home"

  resources :members do
    resources :habits
  end

  resources :feeds, only: [:show, :destroy] do
    resources :post_comments
  end

end
