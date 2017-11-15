Rails.application.routes.draw do
   	# get 'jtj/index'
  	root 'jtj#index'
  	resources :jtj, only: [:index]
  	get '/callback', to: 'sessions#create' #OAUTH Call Back URL
  	post '/comment' => 'jtj#comment'

end
