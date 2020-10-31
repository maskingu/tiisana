Rails.application.routes.draw do
  devise_for :users, only: [:show]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}
root to: "posts#index"
  resources :posts do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  post   '/like/:post_id' => 'likes#like',   as: 'like'
  delete '/like/:post_id' => 'likes#unlike', as: 'unlike'

end
