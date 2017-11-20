Rails.application.routes.draw do
  get 'user/new'

  get 'user/index'

  get 'user/destroy'

  devise_for :users
   	# get 'jtj/index'
  	root 'jtj#index'
  	resources :jtj, only: [:index]
  	get '/callback', to: 'sessions#create' #OAUTH Call Back URL
  	get '/login', to:'oauth#oauth_create'
end
