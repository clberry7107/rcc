Rails.application.routes.draw do
  
  resources :fans
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  
  devise_for :users
  
  resources :users
  
  resources :newreleases do
    collection { post :import }
  end
  
  post 'newseries/import' => 'newseries#import'
  resources :newseries 
  
  post 'subscribers/import' => 'subscribers#import'
  resources :subscribers
  
  post 'books/import' => 'books#import'
  get 'books/order_count' => 'books#order_count'
  post 'books/status' => 'books#index'
  resources :books
  
  post 'relationships/import' => 'relationships#import'
  post 'relationships/sort' => 'relationships#index'
  resources :relationships
  
  get 'subscriptions/index' => 'subscriptions#index'
  post 'subscriptions/update' => 'subscriptions#update'
  post 'subscriptions/add' => 'subscriptions#new'
  post 'subscriptions/create' => 'subscriptions#create'
  post 'subscriber/edit_subscriptions' =>'subscribers#edit_subscriptions'
  
  get 'book_subscribers/index' => 'book_subscribers#index'
  post 'book_subscribers/add' => 'book_subscribers#new'
  post 'book_subscribers/edit' => 'book_subscribers#edit'
  post 'book_subscribers/create' => 'book_subscribers#create'
  post 'book_subscribers/update' => 'book_subscribers#update'
  
  
  resources :fulfillment
  resources :utilities
  

  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  

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
