Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get "dashboards", to: "dashboards#index"
    resources :members, only: [:show, :update, :destroy] do
      resources :habits, only: [:index, :show, :destroy]
      resources :post_comments, only: [:index, :destroy]
      resources :reply_comments, only: [:index, :destroy]
      resources :feeds, only: [:index, :destroy]
    end
  end

  scope module: :public do
    devise_for :members, controllers: {
      registrations: 'public/registrations'
    }
    authenticated :member do
      root to: 'feeds#index', as: :authenticated_root
    end
    post "/guest_sign_in", to: "homes#guest_sign_in"
    get "/search", to: "searches#search"
    delete "/members/:member_id/approve" => "follow_requests#approve", as: "approve"

    root to: "homes#top"
    resources :tags, only: [:show]
    get "/about", to: "homes#about"
    get "/home",  to: "feeds#index"
    get "/profile", to: "members#edit", as: "profile"
    get "/confirm", to: "members#confirm", as: "confirm"
    patch "/withdraw", to:"members#withdraw", as: "withdraw"
    resources :notifications, only: [:update, :show, :index]
    resources :members, except: [:index, :edit] do
      resources :habits
      resource :follow_request, only: [:create, :destroy]
      resource :relationship, only: [:create, :destroy]
        # get "followings" => "relationships#followings", as: "followings"
        # get "followers" => "relationships#followers", as: "followers"
        get "follower" => "relationships#follower", as: "follower"
        get "followed" => "relationships#followed", as: "followed"

    end
    resource :favorite, only: [:create, :destroy]
    resources :feeds, only: [:show, :destroy] do
      resource :favorite, only: [:create, :destroy, :index], defaults: { favoritable_type: 'Feed' }
      resources :post_comments, only: [:create, :show, :destroy] do
        resources :reply_comments, only: [:create, :destroy]
        resource :favorite, only: [:create, :destroy, :index], defaults: { favoritable_type: 'PostComment' }
      end
    end
  end
end
