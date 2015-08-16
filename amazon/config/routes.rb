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
    get "/checkout/addresses", to: "orders#addresses", as: "checkout_address"
    patch "/checkout/addresses", to: "orders#set_addresses"

    get "/checkout/delivery", to: "orders#choose_delivery_service", as: "delivery_service"
    patch "/checkout/delivery", to: "orders#set_delivery_service"

    get "/checkout/credit_card", to: "orders#enter_credit_card", as: "credit_card"
    patch "/checkout/credit_card", to: "orders#set_credit_card"

    get "/checkout/confirm", to: "orders#verify_data", as: "confirmation"
    patch "/checkout/confirm", to: "orders#confirm"

    patch "/state", to: "orders#set_state", as: "state"
  end

  resources :categories, only:[:create, :show, :new]

end
