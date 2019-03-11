Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#workbench"

  resources :instrument_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
    member do
      put 'reset'
      put 'split'
    end
  end

  resources :pooled_instrument_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
  end

  resources :issuer_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
  end

  resources :known_exceptions, :only => [:index, :new, :create] do
    post :bulk_update, :on => :collection
  end

  resources :ambiguous_instruments, :only => [:index] do
    get :bulk_update, :on => :collection

    member do
      put :set_default
      put :set_approved
    end
  end
  
  resources :pooled_instruments
  
  resources :instruments, :only => [:index] do
    collection do
      get 'duplicate'
      post 'resolve_ambiguous'
    end
    
    member do
      put 'set_default'
      put 'set_approved'
      put 'update_effective_date'
      put 'update_expiration_date'
    end
  end
  
  resources :bny_lookups, :only => [:index, :destroy, :create] do
    member do 
      put 'update_effective_date'
      put 'update_expiration_date'
    end    
  end
  
  resources :ssc_lookups, :only => [:index, :destroy, :create] do
    member do 
      put 'update_effective_date'
      put 'update_expiration_date'
    end
  end
  
  resources :jpm_lookups, :only => [:index, :destroy, :create] do
    member do 
      put 'update_effective_date'
      put 'update_expiration_date'
    end        
  end

  resources :agf_lookups, :only => [:index, :destroy, :create]
  resources :horizon_lookups, :only => [:index, :destroy, :create]
  resources :ssc_ca_lookups, :only => [:index, :destroy, :create]
  resources :ssc_ire_lookups, :only => [:index, :destroy, :create]
  resources :asset_class_lookups, :only => [:index, :destroy, :create]
  
  resources :date_adjust_fund_flows, :only => [:index, :destroy, :create] do
    member do 
      put :update_effective_date
      put :update_expiration_date
    end            
  end
  
  resources :instrument_templates, :only => [:create]
  resources :etpr_templates, :only => [:create]
  resources :api_users, :only => [:index, :destroy]
  
  get "/workbench" => "static_pages#workbench"
  get "/lookups" => "static_pages#lookups"
  get "/templates" => "static_pages#templates"
end
