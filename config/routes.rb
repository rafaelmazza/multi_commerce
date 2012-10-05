MultiCommerce::Application.routes.draw do
  root to: "home#index"
  
  resources :leads, only: [:create, :update]
  
  match "unidades" => "home#unities", via: :get
  match "inscricao/:unity_id" => "home#subscribe", via: :get
  match "busca" => "home#search", via: :post
  match "voucher" => "home#voucher", via: :get, as: 'voucher'
end
