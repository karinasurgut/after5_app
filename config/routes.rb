After5::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }
  resources :users, only: :show
  resources :venues
  resources :deals, except: [:new, :show, :index] do
    member do
      put "like",     to: "deals#upvote"
      put "dislike",  to: "deals#downvote"
      put "fave",     to: "deals#want"
      put "checkin",  to: "deals#checkin"
      end
    end
  resources :checkins, only: :create
  root  'static_pages#home'
  match '/users/:id',          to: 'users#show',           as: @user,            via: 'get'
  match '/users/:id/checkins', to: 'users#checkins',       as: :user_checkins,   via: 'get'
  match '/users/:id/wishlist', to: 'users#wishlist',       as: :user_wishlist,   via: 'get'
  match '/users/:id/visited',  to: 'users#visited',        as: :user_visited,    via: 'get'
  match '/terms',              to: 'static_pages#terms',                         via: 'get'
  match '/about',              to: 'static_pages#about',                         via: 'get'
  match '/contact',            to: 'static_pages#contact',                       via: 'get'
  match '/search',             to: 'deals#search',                               via: 'get'
  match '/venues/:id/new',     to: 'venues#deal',          as: :new_deal,        via: 'get'
  match 'deals/tags/:tag',           to: 'deals#search',   as: :tag,             via: 'get'
  match 'venues/tags/:tag',           to: 'venues#index', as: :venue_tag,       via: 'get'
  #match '/venues/new',     to: 'venues#new',           via: 'get'
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
