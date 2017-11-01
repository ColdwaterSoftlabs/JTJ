require 'net/http'

class JtjController < ApplicationController

  	def index
  		
  		url = URI("#{APP_CONFIG[:watermarkchurchURL]}/")
  	    http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["content-type"] = 'application/json'
		response = http.request(request)
		@data = response.read_body
		@val=JSON.parse(@data)

		if @val.present?
			
			curriculumId=@val["curriculum"]["id"]
			url1 = URI("#{APP_CONFIG[:watermarkchurchURL]}/curriculums/#{curriculumId}/entries")
			http1 = Net::HTTP.new(url1.host, url1.port)
			http1.use_ssl = true
			http1.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request1 = Net::HTTP::Get.new(url1)
			request1["content-type"] = 'application/json'
			response1 = http1.request(request1).read_body
			@entityData=JSON.parse(response1)
			# binding.pry
			pp @entityData

			@entityResponse=[];
			
			if @entityData.present?	
				@entityData["entries"].each do |key|
					entityId=key["id"];
					url = URI("#{APP_CONFIG[:watermarkchurchURL]}/entries/#{entityId}")
					http = Net::HTTP.new(url.host, url.port)
					http.use_ssl = true
					http.verify_mode = OpenSSL::SSL::VERIFY_NONE
					request = Net::HTTP::Get.new(url)
					request["content-type"] = 'application/json'
					response = http.request(request)
					@data = response.read_body
					@entityResponse << JSON.parse(@data)
				end
			end

		end
		pp @entityResponse
	end
end
