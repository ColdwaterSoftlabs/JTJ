require 'net/http'
require 'json'

class JtjController < ApplicationController
	before_action :set_discourse_credentials

	def index
		@todayNews={}
	 	begin
			url = ENV['WATERMARKCHURCH_URL']
			uri = URI(url)
			response = Net::HTTP.get(uri)
			@val = JSON.parse(response)
	  	rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
	       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, JSON::ParserError => e
	           # render json: {
	           # 	error: e.to_s
	           # 	}, status: :not_found
	           p e
	           @val = {}

		end
		content = fetch_discource_topic 14
		posts_count = content["posts_count"]
		@posts = content["post_stream"]["posts"]
		p @posts
	end

	def comment
		post = params[:comment]
		create_discourse_post 14, post
		redirect_to root_path
	end

	private

	def set_discourse_credentials
		set_username
		@client = DiscourseApi::Client.new(ENV["DISCOURSE_URL"])
		@client.api_key = ENV["DISCOURSE_API_KEY"]
		@client.api_username = @username
	end

	def fetch_discource_topic topic_id 
		@client.topic(topic_id)
	end

	def create_discourse_post topic_id, post
		@client.create_post(topic_id: topic_id, raw: post)
	end

	def set_username
		if user_signed_in?
			@username = current_user.username
		else
			@username = ENV["DISCOURSE_API_USERNAME"]
		end
	end
end
