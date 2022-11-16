Rails.application.routes.draw do
  root "stocks#index"
  devise_for :users
  resources :stocks 
  resources :transactions

  namespace :admin do
    resources :users
  end
  #non restful routes
  get "/sell_stock/:symbol", to: "trades#sell_stock", as: "sell_stock"
  get "/buy_stock/:symbol", to: "trades#buy_stock", as: "buy_stock"
  get "/find_stock", to: "trades#find_stock", as: "find_stock"
  

end
