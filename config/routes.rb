Rails.application.routes.draw do
  resources :posts,except: :destroy do
    collection do
      get "index_complete"
      get "index_uncomplete"
    end
  end
  root"posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
