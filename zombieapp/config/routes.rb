require 'constraints/api_version'

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Keeping our API under its own subdomain allows load balancing traffic at DNS level
  # Much faster than at application level
  # Very useful when using the same Rails code base to serve both web site and api
  # Using namespace to keep web controllers separate from API controllers
  # Specifying path to remove /api from URLs
  # Watch out, defining a default format override whatever format sent in the Accept header of a request
  namespace :api, path: nil, constraints: {subdomain: 'api'} do
    resources :zombies
    resources :episodes

    # Versioning using URI
    namespace :v1 do
      resources :zombies
      resources :episodes
    end

    namespace :v2 do
      resources :zombies
      resources :episodes
    end


    # Versioning using Accept header
    scope defaults: {format: :json} do
      scope module: :v1, constraints: Constraints::ApiVersion.new('v1') do
        resources :vampires
      end

      scope module: :v2, constraints: Constraints::ApiVersion.new('v2', true) do
        resources :vampires
      end
    end
  end

  resources :zombies  #, only: [:index, :show]
  resources :humans   #, except: [:destroy, :edit, :update]
  resources :pages

  with_options only: :index do |list_only|
    list_only.resources :medical_kits
    list_only.resources :weapons
  end

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
