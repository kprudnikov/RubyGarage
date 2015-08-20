Rails.application.routes.draw do
  root 'books#index'

  devise_for :customers, :controllers => { registrations: 'registrations' }

  resources :addresses
  resources :credit_cards
  resources :books
  resources :ratings, only: [:create]
  resources :authors, only: [:show, :new, :create, :edit, :update]

  resources :orders do
    resources :order_items
    get "/checkout/addresses", to: "checkout#addresses", as: "checkout_address"
    patch "/checkout/addresses", to: "checkout#set_addresses"

    get "/checkout/delivery", to: "checkout#choose_delivery_service", as: "delivery_service"
    patch "/checkout/delivery", to: "checkout#set_delivery_service"

    get "/checkout/credit_card", to: "checkout#enter_credit_card", as: "credit_card"
    patch "/checkout/credit_card", to: "checkout#set_credit_card"

    get "/checkout/confirm", to: "checkout#verify_data", as: "confirmation"
    patch "/checkout/confirm", to: "checkout#confirm"

    patch "/state", to: "orders#set_state", as: "state"
  end

  get "admin/orders", to: "orders#manage", as: "manage_orders"

  resources :categories, only:[:create, :show, :new]

end
