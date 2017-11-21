require 'oauth2'
class OauthController < ApplicationController

	def oauth_create
		client_id = ENV['JTJ_APPLICATION_ID']
		client_secret = ENV['JTJ_APPLICATION_SECRET_KEY']
		site = ENV['WATERMARK_BASE_URL']
		redirect_uri = ENV['REDIRECT_URI']
		client = OAuth2::Client.new(client_id, client_secret, :site => site)
		authorize_url = client.auth_code.authorize_url(:redirect_uri => redirect_uri)
		redirect_to authorize_url
	end

	
end
