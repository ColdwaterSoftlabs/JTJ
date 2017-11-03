class SessionsController < ApplicationController
	def create
  		@auth = {}
  		if params[:code].nil? and @auth.nil? 
	  		
	  	else
	  		@auth["code"]=params[:code]
	  		@auth["state"]=params[:state]
			redirect_to '/' and return
	  	end
	  	pp @auth
	end
end
