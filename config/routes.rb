Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#workbench"

  resources :instrument_exceptions, :only => [:index] do
    post :bulk_update, :on => :collection
  end
  
  get "/workbench" => "static_pages#workbench"
end
