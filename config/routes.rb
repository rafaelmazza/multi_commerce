MultiCommerce::Application.routes.draw do
  root to: "home#index"
  
  resources :leads, only: [:create]
  
  match "unidades" => "home#unities", via: :get
end
