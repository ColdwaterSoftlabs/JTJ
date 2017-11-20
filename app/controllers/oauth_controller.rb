require 'oauth2'
class OauthController < ApplicationController
	def oauth_create
		client = OAuth2::Client.new(ENV['JTJ_APPLICATION_ID'], ENV['JTJ_APPLICATION_SECRET_KEY'], :site => ENV['WATERMARK_BASE_URL'])
		client.auth_code.authorize_url(:redirect_uri => "https://jtj-dev.herokuapp.com/callback")
		token = client.client_credentials.get_token
		get_user_details token['access_token']
		p 'token created'
		render json: token 
	end

	private

	def get_user_details token
		# Have to fetch real user email
		username = "jtj#{rand(252...4350)}"
		email = "#{username}@jtj.com"
		create_user email, username, token
	end

	def create_user email, username
		generated_password = Devise.friendly_token.first(8)
		discourse_email = email #should be changed to dummy email, not from the user details email
		user = User.create!(email: email, password: generated_password, password_confirmation: generated_password, username: username, wcc_access_token: token, discourse_email: discourse_email)
	end

	def create_discourse_user
	end 
end
