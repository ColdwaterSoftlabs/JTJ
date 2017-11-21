require 'oauth2'
class OauthController < ApplicationController
	before_action :set_discourse_credentials

	def oauth_create
		client = OAuth2::Client.new(ENV['JTJ_APPLICATION_ID'], ENV['JTJ_APPLICATION_SECRET_KEY'], :site => ENV['WATERMARK_BASE_URL'])
		client.auth_code.authorize_url(:redirect_uri => "https://jtj-dev.herokuapp.com/callback")
		token = client.client_credentials.get_token
		# p token
		# response = token.get('/api/v1/me.json', :headers => { 'Authorization' =>  "Basic #{token}"})
		# p response
		# get_user_details token['access_token']
		# get_user_details "accesstokenabcedefk"
		p 'token created'
		render json: token
		# redirect_to root_path 
	end

	private

	def get_user_details token
		# Have to fetch real user email
		username = "jtj#{rand(252...4350)}"
		email = "#{username}@jtj.com"
		create_user email, username, token
	end

	def create_user email, username, token
		generated_password = Devise.friendly_token.first(8)
		discourse_email = email #should be changed to dummy email, not from the user details email
		@user = User.create!(email: email, password: generated_password, password_confirmation: generated_password, username: username, wcc_access_token: token, discourse_email: discourse_email)
		p "User created Successfully"
		sign_in(@user)
		p "User signed in Succesfully"
		create_discourse_user
	end

	def create_discourse_user
		user = @client.create_user(
			name: @user.username,
			email: @user.discourse_email,
			username: @user.username,
			password: "#{@user.discourse_email.reverse}"
		)
		p "----------Discourse user details--------------------"
		p user
		activate_discourse_user user
	end 

	def set_discourse_credentials
		@client = DiscourseApi::Client.new(ENV["DISCOURSE_URL"])
		@client.api_key = ENV["DISCOURSE_API_KEY"]
		@client.api_username = ENV["DISCOURSE_API_USERNAME"]
	end

	def activate_discourse_user user
		p "Discourse user activated"
		@client.activate(user["user_id"])
	end
end
