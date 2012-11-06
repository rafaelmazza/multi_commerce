require 'sidekiq/web'

MultiCommerce::Application.routes.draw do
  # themes_for_rails
  
  devise_for :backend_users, path: 'backend'
  mount RailsAdmin::Engine => '/backend', :as => 'rails_admin'

  devise_for :users 
  devise_scope :user do
    get 'users', :to => 'admin/dashboard#index', :as => :user_root # redirect to admin root after update password
  end

  backend_user_authenticated = lambda { |request| request.env["warden"].authenticate? and request.env["warden"].user }
  constraints backend_user_authenticated do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  root to: "home#index"
  
  resources :leads, only: [:create, :update]
  # resources :vouchers, only: [:show, :update] do
  resources :vouchers do
    # post :update_payment_method, on: :member
    put :checkout, on: :member
    get :success, on: :member
  end
  
  match "update_payment_status" => "vouchers#update_payment_status", via: :post
  
  match "unidades" => "home#unities", via: :get, as: 'unities'
  match "inscricao/:unity_id" => "home#subscribe", via: :get
  match "busca" => "home#search", via: :post
  # match "voucher" => "home#voucher", via: :get, as: 'voucher'
  # match "sucesso" => "vouchers#success", via: :get, as: 'success'
  match "privacidade" => "home#privacy_policy", as: 'privacy_policy'
  
  # match "/address" => "addresses#index", via: :get
  match "addresses/:zipcode" => "addresses#show"
  resources :addresses  
  
  namespace :admin do
    root to: "dashboard#index"
    match 'unities/available' => "dashboard#available_unities", as: :available_unities
    match 'unities/select/:unity_id' => "dashboard#select_unity", as: :select_unity
    
    # root to: "leads#index"
    resources :leads, only: [:index, :show] do
      post :prospect, on: :collection
      post :enroll, on: :collection
      match "search" => "leads#index", :via => [:get, :post], :as => :search, on: :collection
    end
    resources :vouchers, only: [:index, :show] do
      resources :payments, only: [:index]
      match "search" => "vouchers#index", :via => [:get, :post], :as => :search, on: :collection
      put :use, on: :member
    end
    resources :unities, only: [:index] do
      match "search" => "unities#index", :via => [:get, :post], :as => :search, on: :collection
      get :ranking, on: :collection
    end
  end
  
  match "installments" => "vouchers#installments" #tmp
  
  match "/:source" => "home#index", constraints: {source: /!(favicon)/}
end
