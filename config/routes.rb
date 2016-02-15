Rails.application.routes.draw do


  #match ':controller(/:action(/:id))', :via => [:get, :post]
  root "access#login"
  get '/:locale' => 'access#login'

  

  scope "(:locale)", locale: /es|en/ do
    resources :professionals do
      member do
        get :delete
      end
      resources :companies do
        member do
          get :delete
        end
      end
      resources :branches do
        member do
          get :delete
        end
      end
      resources :clients do
        member do
          get :delete
        end
      end
      resources :appointments do
        member do
          get :delete
        end
      end
    end
  
  end

  scope "(:locale)", locale: /es|en/ do
    resources :companies do
      member do
        get :delete
      end
      resources :professionals do
        member do
          get :delete
        end
      end
      resources :branches do
        member do
          get :delete
        end
      end
      resources :clients do
        member do
          get :delete
        end
      end
      resources :appointments do
        member do
          get :delete
        end
      end
    end
  
  end

  scope "(:locale)", locale: /es|en/ do
    resources :access do
      collection do
        get :professional_new
        post :professional_create
        get :professional_delete
        post :professional_destroy

        get :company_new
        post :company_create
        get :company_delete
        post :company_destroy
      end
    end
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
