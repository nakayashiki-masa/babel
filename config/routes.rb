Rails.application.routes.draw do
  get "posts/about"
  get 'users/show'
  devise_for :users
  resources :users, :only => [:show] do
  end

  resources :posts, except: :destroy do

    collection do
      get "index_complete"
      get "index_uncomplete"
    end

    member do
      patch "complete"
    end

  end

  root "posts#index"

end
