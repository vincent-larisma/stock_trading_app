Rails.application.routes.draw do
  root "stocks#index"
  devise_for :users
  
  namespace :admin do
    resources :users
    resources :pending, only: [:index]
  end

  resources :stocks 
  resources :transactions

  
  #non restful routes
  get "/sell_stock/:symbol", to: "trades#sell_stock", as: "sell_stock"
  get "/buy_stock/:symbol", to: "trades#buy_stock", as: "buy_stock"
  get "/find_stock", to: "trades#find_stock", as: "find_stock"
  

end
