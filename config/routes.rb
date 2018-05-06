Rails.application.routes.draw do
  get 'users/show'

  devise_for :users

  resources :users, :only => [:show]

  resources :posts, except: :destroy do

    collection do
      get "index_complete"
      get "index_uncomplete"
    end

    member do
      patch "complete"
      # patch "index_uncomplete"
    end

  end

  root"posts#index"

end
