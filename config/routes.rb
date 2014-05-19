Rails.application.routes.draw do

  get 'produits/index'

  namespace :client do
  get 'liste_favorises/index'
  resources :client do 
      resources :liste_favorises, only: [:new, :create]
    end
  end

  namespace :client do
  get 'liste_noires/index'
  resources :client do 
      resources :liste_noires, only: [:new, :create]
    end
  end

  namespace :client do
    get 'magasins/index'
    post 'produits/index'
    post 'type_de_produits/index'
    post 'sources/index'
    get 'liste_acheters/index'
    resources :client do 
      resources :liste_acheters, only: [:new, :create]
    end
  end

  namespace :api do
    post 'clients/sign_in'
    delete 'clients/sign_out' 
    get 'clients/liste_magasins'
    post 'clients/produits_magasin'
    post 'clients/produits_type'
    post 'clients/produits_source'
    post 'clients/liste_types'
    post 'clients/liste_sources'
    post 'clients/scan_nfc'
    post 'clients/show_produit'
    post 'clients/add_liste_acheter'
    post 'clients/show_liste_acheter'
    post 'clients/add_liste_favorise'
    post 'clients/show_liste_favorise'
    post 'clients/add_liste_noire'
    post 'clients/show_liste_noire'

  end

  namespace :magasin do
  get 'type_de_produits/index'
    resources :magasin do 
      resources :type_de_produits, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  namespace :magasin do
  get 'nfcs/index'
  resources :magasin do 
      resources :nfcs, only: [:new, :create, :edit, :update]
    end
  end

  namespace :magasin do
    get 'sources/index'
    resources :magasin do 
      resources :sources, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  namespace :magasin do
    get 'franchises/index'
  end

  namespace :magasin do
    get 'produits/index'
    get 'magasins/index' 
    resources :magasin do
      resources :produits, only: [:new, :create, :show, :edit, :update, :destroy]
    end
  end


  devise_for :vendeurs

  namespace :admin do
    
    get 'magasin/index'

    resources :franchises do 
      resources :magasin, only: [:new, :create]
    end

    resources :magasin do 
      resources :vendeurs, only: [:new, :create]
    end

  end

  namespace :admin do
    get 'clients/index'
    get 'franchises/index'
    get 'franchises/new'
    post 'franchises/create'
  end

  

  get 'magasins/index'
  

  devise_for :admins
  devise_for :clients
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'
   
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
