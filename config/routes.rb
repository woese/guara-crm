Guara::Application.routes.draw do  

  mount GuaraStore::Engine => "/store"

  ActiveAdmin.routes(self)

  resources :company_businesses

  resources :districts
  resources :business_departments
  resources :task_types
  resources :system_task_status

  devise_for :users#, :controllers => { :sessions => "sessions" } do
#    #get "/signup" => "devise/registrations#new", :as => 'user_signup'
#    #get '/logout' => 'devise/sessions#destroy', :as => 'user_logout'
#    #get '/login' => "devise/sessions#new", :as => 'user_login'
#    get 'get_token' => 'sessions#get_token'
#    match 'sessions', :to => 'static_pages#home'
#  end

  resources :business_activities
  resources :business_segments

  root to: 'static_pages#home' 
  
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  
  #authenticate
  #match '/signup',  to: 'users#new'
  #match '/signin',  to: 'sessions#new'
  #match '/signout', to: 'sessions#destroy', via: :delete
  
  #match '/sigup', to: ''
  
  #resources
  resources :users do
  #  resources :sessions
    resources :abilities
  end
  #resources :sessions #,   only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :customers do
    get :autocomplete_business_segment_name, :on => :collection
    get :autocomplete_business_activity_name, :on => :collection
    
    get :multiselect_business_segments, :on => :collection
    get :multiselect_business_activities, :on => :collection
    
    get :customer_pj, :on => :collection
    
    get :multiselect_customers_pj, :on => :collection
    
    resources :contacts
    resources :tasks do
      resources :feedbacks
    end
  end
  
  namespace :tests do
    resources :ajaxes do
      collection do
        get 'add_and_update'
        get 'add'
        get 'all'
      end
    end
    
    resources :lab_ajax
  end
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
