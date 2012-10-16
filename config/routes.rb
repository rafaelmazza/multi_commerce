require 'sidekiq/web'

MultiCommerce::Application.routes.draw do
  devise_for :backend_users, path: 'backend'
  mount RailsAdmin::Engine => '/backend', :as => 'rails_admin'

  devise_for :users

  mount Sidekiq::Web, at: "/sidekiq"
  
  root to: "home#index"
  
  resources :leads, only: [:create, :update]
  # resources :vouchers, only: [:show, :update] do
  resources :vouchers do
    # post :update_payment_method, on: :member
    put :checkout, on: :member
  end
  
  match "update_payment_status" => "vouchers#update_payment_status", via: :post
  
  match "unidades" => "home#unities", via: :get
  match "inscricao/:unity_id" => "home#subscribe", via: :get
  match "busca" => "home#search", via: :post
  # match "voucher" => "home#voucher", via: :get, as: 'voucher'
  
  # match "/address" => "addresses#index", via: :get
  match "addresses/:zipcode" => "addresses#show"
  resources :addresses  
  
  namespace :admin do
    root to: "leads#index"
    resources :leads, only: [:index]
    resources :vouchers, only: [:index]
  end
  
  match "installments" => "vouchers#installments" #tmp
end
