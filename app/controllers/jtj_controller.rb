require 'net/http'
require 'json'

class JtjController < ApplicationController

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
	end
end
