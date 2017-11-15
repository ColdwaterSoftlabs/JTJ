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
		content = fetch_discource_topic 14
		posts_count = content["posts_count"]
		@posts = content["post_stream"]["posts"]
		p @posts
	end

	private

	def set_discourse_credentials
		@client = DiscourseApi::Client.new(ENV["DISCOURSE_URL"])
		@client.api_key = ENV["DISCOURSE_API_KEY"]
		@client.api_username = ENV["DISCOURSE_API_USERNAME"]
	end

	def fetch_discource_topic topic_id 
		@client.topic(topic_id)
	end

	def create_discourse_post topic_id, post
		@client.create_post(topic_id: topic_id, raw: post)
	end
end
