Rails.application.routes.draw do
   	get 'jtj/index'
  	root 'jtj#index'
  	resources :jtj, only: [:index]
  	get '/auth/provider/callback', to: 'sessions#create' #OAUTH Call Back URL
end
