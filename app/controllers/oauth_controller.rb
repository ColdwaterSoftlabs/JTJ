require 'oauth2'
class OauthController < ApplicationController
	def oauth_create
		client = OAuth2::Client.new("#{APP_CONFIG[:JTJ_APPLICATION_ID]}", "#{APP_CONFIG[:JTJ_APPLICATION_SECRET_KEY]}", :site => "#{APP_CONFIG[:OAUTH_BASE_URL]}")
		client.auth_code.authorize_url(:redirect_uri => "#{APP_CONFIG[:OAUTH_CALL_BACK_URL]}")
		token = client.client_credentials.
		render json: token 
	end
end
