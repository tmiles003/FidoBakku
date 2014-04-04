FidoBakku::Application.routes.draw do
  
  root 'welcome#index'
  
  resources :account, only: [:create, :new]

  devise_for :users, 
    :path => '',
    :path_names => { :sign_in => 'login', :sign_out => 'logout' },
    :skip => [:registrations]
  
  # get '/' => 'welcome#application', as: :dashboard
  get '/.*', :to => 'welcome#application', as: :app_root
  
  get 'user/:id' => 'welcome#application', as: :user_manage
  get 'goal/:id' => 'welcome#application', as: :goal_manage
  get 'form/:id' => 'welcome#application', as: :form_manage
  #get 'reviews/:id/:slug' => 'welcome#application', as: :review_manage
  #get 'review/:id/:name' => 'welcome#application', as: :user_review
  #get 'feedback/:id/:name' => 'welcome#application', as: :user_feedback
  
  namespace :api, defaults: { format: :json } do
    
    get 'session' => 'session#index'
    #get 'dashboard/reviews' => 'dashboard#reviews'
    #get 'dashboard/feedbacks' => 'dashboard#feedbacks'
    
    resources :users, except: [:new] do 
      collection do 
        get 'current'
        get 'list'
        get 'roles'
      end
    end
    
    resources :teams, except: [:show, :new, :edit]
    
    resources :goals, except: [:new, :edit] do
      collection do
        get 'team'
      end
    end
    
    resources :sections, except: [:index, :show, :new, :edit] do 
      resources :comps, except: [:show, :new, :edit], shallow: true do 
        member do 
          put 'up'
          put 'down'
        end
      end
    end
    resources :forms, except: [:new] do
      collection do 
        get 'list'
      end
      member do
        put 'user/:user_id' => 'forms#user'
      end
      resources :sections, only: [:index], shallow: true do 
        member do 
          put 'up'
          put 'down'
        end
      end
    end
    
    resources :reviews, except: [:new, :edit] do 
      collection do 
        get 'statuses'
      end
    end
    resources :user_reviews, except: [:new, :edit]
    resources :comments, except: [:show, :new, :create, :edit]
    
    resource :account, controller: :account, only: [:show, :update, :destroy]
    resource :user, path: '/profile', controller: :profile, only: [:update]
    
  end

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
