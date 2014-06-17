Rails.application.routes.draw do

  resources :current_videos

  resources :footer_news

  resources :menus

  #Isto tem de ficar no inicio, desta forma faz overwrite ao contents/ID
  #Se isto estiver la em baixo nao funciona, so funciona o contents/ID
  #get 'contents/:title' => 'contents#show'

  resources :free_classrooms

  resources :classrooms

  resources :bookmarked_contents

  resources :user_contents

  resources :scores

  resources :games

  resources :content_videos

  resources :videos

  resources :tag_contents

  resources :tags

  resources :contents

  devise_for :users
  resources :users

  get 'homepage/feeds' => 'homepage#feeds'

  get 'homepage/index'
  get 'tv' => 'tv#show'

  #get '/users/:id/scores' => ''

  # get 'homepage/updateInfo' => 'homepage#updateInfo'
  # get 'homepage/sync' => 'homepage#sync'

  root 'homepage#index'

  resources :users do
    resources :scores
    resources :bookmarked_contents
    resources :user_contents
    resources :free_classrooms
  end

  get ':name' => 'users#show', as: 'user_name'

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
