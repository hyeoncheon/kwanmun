Rails.application.routes.draw do
 scope '/kwanmun' do
  concern :client do
    resources :logs, shallow: :true do
      put :dismiss, on: :member
    end
    resources :accesses
  end

  resources :servers, concerns: :client, shallow: :true
  resources :users, concerns: :client, shallow: :true

  resources :services, shallow: :true do
    resources :accesses
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :logs
      get 's/:service_name/*path', to: 'gateway#get'
      post 's/:service_name/*path', to: 'gateway#post'
      put 's/:service_name/*path', to: 'gateway#put'
      delete 's/:service_name/*path', to: 'gateway#delete'
    end
  end

  ### hyeoncheon.siso
  get '/auth/siso', as: :signin
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/signout', to: 'sessions#signout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'logs#index'

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
end
