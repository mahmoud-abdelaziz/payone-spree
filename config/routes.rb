Spree::Core::Engine.routes.draw do
  Spree::Core::Engine.routes.draw do
    resources :orders do
      resource :checkout, :controller => 'checkout' do
        member do
          get :payone_success
          get :payone_error
          get :payone_back
        end
      end
    end
    
    namespace :admin do
      resources :orders do
        resources :payments do
          member do
            get :payone_success
            get :payone_error
            get :payone_back
          end
        end
      end
      
      resource :payone_settings do
        collection do
          post :dismiss_alert
        end
      end
      
      resources :payone_logs do
        collection do
          get :clear
        end
      end
      
      resource :payone_docs do
      end
    end
  end
end
