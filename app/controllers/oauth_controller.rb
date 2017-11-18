require 'oauth2'
class OauthController < ApplicationController
	def oauth_create
		client = OAuth2::Client.new(ENV['WATERMARK_CLIENT_ID'], ENV['WATERMARK_CLIENT_SECRET'], :site => ENV['WATERMARK_BASE_URL')
		client.auth_code.authorize_url(:redirect_uri => "https://jtj-dev.herokuapp.com/callback")
		token = client.client_credentials.get_token
		User.create token:token
		p 'token created'
		render json: token 
	end
end