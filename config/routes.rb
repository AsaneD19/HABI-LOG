Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get "dashboards", to: "dashboards#index"
    resources :members, only: [:destroy]
  end

  scope module: :public do
    devise_for :members
    post "/guest_sign_in", to: "homes#guest_sign_in"
    get "/search", to: "searches#search"
    delete "/members/:member_id/approve" => "follow_requests#approve", as: "approve"

    root to: "homes#top"
    get "/about", to: "homes#about"
    get "/home",  to: "feeds#index"
    get "/profile", to: "members#edit", as: "profile"
    resources :notifications, only: [:update, :show, :index]
    resources :members, except: [:edit] do
      resources :habits
      resource :follow_request, only: [:create, :destroy]
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
end
