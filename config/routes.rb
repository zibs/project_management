Rails.application.routes.draw do


  get 'index' => "home#index"
  get 'about' => "home#about"
  root "projects#index"

  resources :projects do
    resources :tasks, only: [:create, :destroy, :update]
    resources :discussions, only: [:create, :edit, :destroy]
    resources :favourites, only: [:create, :destroy]
  end

  resources :favourites, only: [:index]

  resources :discussions, only: [:show, :update, :edit] do
    resources :comments, only: [:create, :edit, :destroy]
  end

  resources :comments, only: [:update, :edit]
  resources :users, only: [:new, :create, :edit, :update] do

  end
  get "users/:id/update-password" => "users#edit_password", as: :edit_password
  patch "users/:id/update-password" => "users#update_password", as: :update_password

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
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
