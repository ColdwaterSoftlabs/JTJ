require 'net/http'
require 'json'

class JtjController < ApplicationController

	def index
		# @todayNews={}
	 # 	begin
		# 	url = ENV['WATERMARKCHURCH_URL']
		# 	uri = URI(url)
		# 	response = Net::HTTP.get(uri)
		# 	@val = JSON.parse(response)
	 #  	rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
	 #       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, JSON::ParserError => e
	 #           # render json: {
	 #           # 	error: e.to_s
	 #           # 	}, status: :not_found
	 #           p e
	 #           @val = {}
		# end
		user = User.find_by_email("vigneshsika@gmail.com")
		if user.nil?
		  user = User.create(field_1: value1, field_2: value2)    
		end

		sign_in(user)
		binding.pry
		redirect_to after_sign_in_path(user)
	end
end
