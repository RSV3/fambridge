Fambridge::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'micro#tools_landing'

  match '/start', to: 'main#index', via: 'get'
  match '/home', to: 'main#home', via: 'get'
  match '/about', to: 'main#about', via: 'get'
  match '/privacy', to: 'main#privacy', via: 'get'
  match '/contact', to: 'main#contact', via: 'get'
  match '/help', to: 'main#help', via: 'get'
  match '/terms', to: 'main#terms', via: 'get'
  match '/tour', to: 'main#tour', via: 'get'

  match '/calculator', to: 'micro#tools_landing', via: 'get'
  match '/reversemort', to: 'micro#tools_landing', via: 'get'
  match '/savingstool', to: 'micro#tools_landing', via: 'get'
  match '/tracking', to: 'micro#tools_landing', via: 'get'
  match '/caretool', to: 'micro#tools_landing', via: 'get'
  match '/social', to: 'micro#tools_landing', via: 'get'
  match '/interest/reversemort', to: 'micro#launching_soon', via: 'get'
  match '/interest/savingstool', to: 'micro#launching_soon', via: 'get'
  match '/interest/assisted', to: 'micro#launching_soon', via: 'get'

  match '/will/notify', to: 'micro#lead_saved', via: 'post', as: :lead_saved

  resources :content do
    collection do
      get :recent, as: :recent
    end
  end

  # display articles
  get '/content/category/:slug', to: 'content#index', constraints: { slug: /[a-z0-9\-]+/ }, as: :category
  get '/content/:category/:id', to: 'content#show', constraints: { id: /[a-z0-9\-]+/ }, as: :article

  resources :users

  match '/signup', to: 'users#new', via: 'get'
  match '/family', to: 'users#family', via: 'get'

  resources :sessions, only: [:new, :create, :destroy]
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :feeds, only: [:create, :destroy]
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
