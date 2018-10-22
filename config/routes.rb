Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#workbench"

  resources :instrument_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
  end

  resources :pooled_instrument_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
  end

  resources :issuer_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
  end

  resources :known_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
  end

  resources :ambiguous_instruments, :only => [:index] do
    post :bulk_update, :on => :collection
  end
  
  resources :instruments, :only => [:index, :show]
  
  resources :bny_lookups, :only => [:index, :destroy, :create]
  
  resources :ssc_lookups, :only => [:index, :destroy, :create] do
    member do 
      put :update_effective_date
      put :update_expiration_date
    end
  end
  
  resources :jpm_lookups, :only => [:index, :destroy, :create]
  
  get "/workbench" => "static_pages#workbench"
  get "/lookups" => "static_pages#lookups"
end
