Rails.application.routes.draw do
  get '/uploads/:filename', to: 'uploads#show', constraints: { filename: /.*/ }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'static_pages#top'
  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update] do
    patch :update_password, on: :member
  end
  resources :reviews, only: %i[index new create show edit update destroy] do
    resource :like, only: [:create, :destroy]
    resources :comments, only: %i[create destroy]
  end

  namespace :admin do
    root 'dashboards#index'  # ← ダッシュボードを管理画面のトップページに設定
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        patch :reset_password
      end
    end
    resources :reviews, only: [:index, :show, :destroy] #投稿管理追加
  end

  resources :gummies, only: %i[index]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'likes', to: 'users#likes'
end
