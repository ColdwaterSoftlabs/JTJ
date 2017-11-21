class SessionsController < ApplicationController
	def create
  		@auth = {}
  		if params[:code].nil? and @auth.nil? 
	  		p "Some error occured, no code"
	  	else
	  		p "Printing params"
	  		p params
	  		@auth["code"]=params[:code]
	  		@auth["state"]=params[:state]
	  		token = client.auth_code.get_token(@auth['code'], :redirect_uri => redirect_uri)
	  		#store access_token and refresh token
	  		get_user_details token
	  		redirect_to '/' and return
	  	end
	  	p @auth
	end

	private

	def get_user_details token
		# Have to fetch real user email
		# username = "jtj#{rand(252...4350)}"
		# email = "#{username}@jtj.com"
		response = token.get('/api/v1/me.json')
	  	user = JSON.parse(response.body)
	  	email = user["email"]
	  	first_name = user["first_name"]
		create_user email, first_name
	end

	def create_user email, username
		generated_password = Devise.friendly_token.first(8)
		discourse_email = "#{username}@jtj.com" #should be changed to dummy email, not from the user details email
		@user = User.create!(email: email, password: generated_password, password_confirmation: generated_password, username: username, discourse_email: discourse_email)
		p "User created Successfully"
		sign_in(@user)
		p "User signed in Succesfully"
		create_discourse_user
	end

	def create_discourse_user
		set_discourse_credentials
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
