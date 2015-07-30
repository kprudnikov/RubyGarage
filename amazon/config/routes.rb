Rails.application.routes.draw do
  get 'ratings/create'

  # devise_for :customers
  devise_for :customers, :controllers => { registrations: 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'customers#login'
  root 'books#index'

  resources :addresses, only: [:create, :new, :index]
  resources :credit_cards
  resources :books
  resources :ratings, only: [:create]
  resources :authors, only: [:show, :new, :create]
  resources :orders do
    resources :order_items
  end
  resources :categories
  resources :order_items, only: [:destroy]

#                       Prefix Verb   URI Pattern                                      Controller#Action
#         new_customer_session GET    /customers/sign_in(.:format)                     devise/sessions#new
#             customer_session POST   /customers/sign_in(.:format)                     devise/sessions#create
#     destroy_customer_session DELETE /customers/sign_out(.:format)                    devise/sessions#destroy
#            customer_password POST   /customers/password(.:format)                    devise/passwords#create
#        new_customer_password GET    /customers/password/new(.:format)                devise/passwords#new
#       edit_customer_password GET    /customers/password/edit(.:format)               devise/passwords#edit
#                              PATCH  /customers/password(.:format)                    devise/passwords#update
#                              PUT    /customers/password(.:format)                    devise/passwords#update
# cancel_customer_registration GET    /customers/cancel(.:format)                      registrations#cancel
#        customer_registration POST   /customers(.:format)                             registrations#create
#    new_customer_registration GET    /customers/sign_up(.:format)                     registrations#new
#   edit_customer_registration GET    /customers/edit(.:format)                        registrations#edit
#                              PATCH  /customers(.:format)                             registrations#update
#                              PUT    /customers(.:format)                             registrations#update
#                              DELETE /customers(.:format)                             registrations#destroy
#                         root GET    /                                                books#index
#                    addresses GET    /addresses(.:format)                             addresses#index
#                              POST   /addresses(.:format)                             addresses#create
#                  new_address GET    /addresses/new(.:format)                         addresses#new
#                 credit_cards GET    /credit_cards(.:format)                          credit_cards#index
#                              POST   /credit_cards(.:format)                          credit_cards#create
#              new_credit_card GET    /credit_cards/new(.:format)                      credit_cards#new
#             edit_credit_card GET    /credit_cards/:id/edit(.:format)                 credit_cards#edit
#                  credit_card GET    /credit_cards/:id(.:format)                      credit_cards#show
#                              PATCH  /credit_cards/:id(.:format)                      credit_cards#update
#                              PUT    /credit_cards/:id(.:format)                      credit_cards#update
#                              DELETE /credit_cards/:id(.:format)                      credit_cards#destroy
#                        books GET    /books(.:format)                                 books#index
#                              POST   /books(.:format)                                 books#create
#                     new_book GET    /books/new(.:format)                             books#new
#                    edit_book GET    /books/:id/edit(.:format)                        books#edit
#                         book GET    /books/:id(.:format)                             books#show
#                              PATCH  /books/:id(.:format)                             books#update
#                              PUT    /books/:id(.:format)                             books#update
#                              DELETE /books/:id(.:format)                             books#destroy
#                      authors POST   /authors(.:format)                               authors#create
#                   new_author GET    /authors/new(.:format)                           authors#new
#                       author GET    /authors/:id(.:format)                           authors#show
#            order_order_items GET    /orders/:order_id/order_items(.:format)          order_items#index
#                              POST   /orders/:order_id/order_items(.:format)          order_items#create
#         new_order_order_item GET    /orders/:order_id/order_items/new(.:format)      order_items#new
#        edit_order_order_item GET    /orders/:order_id/order_items/:id/edit(.:format) order_items#edit
#             order_order_item GET    /orders/:order_id/order_items/:id(.:format)      order_items#show
#                              PATCH  /orders/:order_id/order_items/:id(.:format)      order_items#update
#                              PUT    /orders/:order_id/order_items/:id(.:format)      order_items#update
#                              DELETE /orders/:order_id/order_items/:id(.:format)      order_items#destroy
#                       orders GET    /orders(.:format)                                orders#index
#                              POST   /orders(.:format)                                orders#create
#                    new_order GET    /orders/new(.:format)                            orders#new
#                   edit_order GET    /orders/:id/edit(.:format)                       orders#edit
#                        order GET    /orders/:id(.:format)                            orders#show
#                              PATCH  /orders/:id(.:format)                            orders#update
#                              PUT    /orders/:id(.:format)                            orders#update
#                              DELETE /orders/:id(.:format)                            orders#destroy
#                   categories GET    /categories(.:format)                            categories#index
#                              POST   /categories(.:format)                            categories#create
#                 new_category GET    /categories/new(.:format)                        categories#new
#                edit_category GET    /categories/:id/edit(.:format)                   categories#edit
#                     category GET    /categories/:id(.:format)                        categories#show
#                              PATCH  /categories/:id(.:format)                        categories#update
#                              PUT    /categories/:id(.:format)                        categories#update
#                              DELETE /categories/:id(.:format)                        categories#destroy
#                   order_item DELETE /order_items/:id(.:format)                       order_items#destroy


  # get "/customers/:id/last_order_in_progress" => "customers#last_order_in_progress", as: "last_order"
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
