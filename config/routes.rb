Clip::Application.routes.draw do

  resource :user_session

  resources :users

  root :to => "users#index"

  match '/rpc/:action' => 'rpc'
end
