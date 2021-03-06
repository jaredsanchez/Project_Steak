ProjectSteak::Application.routes.draw do
  get "main/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.
  get 'events/add_person/:id', to: 'events#add_person'
  get 'events/add_group/:id', to: 'events#add_group'

  get 'events/refresh', to: 'events#refresh', as: :refresh
  match 'events/calendar', to: 'events#calendar'
  get 'events/send_invites/:id', to: 'events#send_invites'
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  root :to => 'main#index'
  resources :people
  resources :groups
  resources :events

  match '/auth/failure' => 'sessions#failure'

  match '/signout' => 'sessions#destroy', :as => :signout

  match '/signin' => 'sessions#new', :as => :signin

  match '/linkedin_signin' => 'sessions#new_linkedin', :as => :linkedin_signin

  match '/auth/:provider/callback' => 'sessions#create'

  get "sessions/new"

  get "sessions/create"

  get "sessions/failure"

  get '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure' 


  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
