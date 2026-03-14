Rails.application.routes.draw do
  namespace :admin do
    root to: "dashboards#index"
    resources :products
    resources :distributors do
      resources :skus, except: [:show, :destroy]
    end
  end
  
  resources :orders, only: [:index, :new, :create, :show]

  devise_for :users
  
  # Distributor Root
  authenticated :user, ->(u) { u.distributor? } do
    root to: "orders#index", as: :distributor_root
  end

  # Admin Root (as fallback)
  authenticated :user, ->(u) { u.admin? } do
    root to: "admin/dashboards#index", as: :authenticated_admin_root
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#index"
end
