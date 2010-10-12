Clip::Application.routes.draw do

  resource :user_session

  resources :users

  match '/rpc/:action' => 'rpc'
end
