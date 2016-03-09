Rails.application.routes.draw do

  get 'index' => "home#index"
  get 'about' => "home#about"
  root "projects#index"

  resources :projects do
    resources :tasks, only: [:create, :destroy, :update]
    resources :discussions, only: [:create, :edit, :destroy]
    resources :favourites, only: [:create, :destroy]
  end
  resources :tasks, only: [:edit, :update]  do
   post :sort, on: :collection
  end

  resources :favourites, only: [:index]

  resources :discussions, only: [:show, :update, :edit] do
    resources :comments, only: [:create, :destroy, :update, :edit]
  end

  resources :users, only: [:new, :create, :edit, :update] do

  end
  get "users/:id/update-password" => "users#edit_password", as: :edit_password
  patch "users/:id/update-password" => "users#update_password", as: :update_password

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  namespace :api, defaults: {format: :json } do
    namespace :v1 do
      resources :projects, only: [:index, :show, :create] do
        resources :tasks, only: [:create]
      end
      resources :discussions, only: [:show]
    end
  end

  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callbacks#twitter"

  get "/auth/github", as: :sign_in_with_github
  get "/auth/github/callback" => "callbacks#github"

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
