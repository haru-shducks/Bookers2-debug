Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about"=>"homes#about"

  devise_for :users

  #検索機能
  get "/search", to: "searches#search"

  resources :users, only: [:index,:show,:edit,:update] do
    get "search" => "users#search"
    #フォロー、フォロワー機能
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    #いいね機能ルート
    resources :favorites, only: [:create, :destroy]
    #コメント機能ルート
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
