require 'net/http'
require 'json'

class JtjController < ApplicationController
	before_action :set_discourse_credentials

	def index
		@todayNews={}
	 	begin
			url = "#{APP_CONFIG[:watermarkchurchURL]}/"
			uri = URI(url)
			response = Net::HTTP.get(uri)
			@val = JSON.parse(response)
	  	rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
	       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
	           render json: {
	           	error: e.to_s
	           	}, status: :not_found
		end
		if @todayNews.nil?
		else
			# @todayNews=@val["latest_entry"]["scripture"]["html"];
			# UserEmailNotificationMailer.send_email_notify(@todayNews).deliver
		end
		response = fetch_discource_topic 14
		if response.code == 200
			content = JSON.parse(response.body)
			posts_count = content["posts_count"]
			@posts = content["post_stream"]["posts"]
			p @posts
		else
			p "error fetching topic"
		end
	end

	private

	def set_discourse_credentials
		@url = ENV["DISCOURSE_URL"]
		@api_key = ENV["DISCOURSE_API_KEY"]
		@api_username = ENV["DISCOURSE_API_USERNAME"]
	end

	def fetch_discource_topic topic_id 
		url = "#{@url}/t/#{topic_id}.json?api_key=#{@api_key}&api_username=#{@api_username}"
		p url
		response = RestClient.get(url)
	end
end
