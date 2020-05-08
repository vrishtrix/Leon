require "halite"
require "json"
require "http/client"

class Athena::Client
	setter :async

	def initialize(
		@endpoint : String,
		@username : String,
		@password : String
	)
		@jwt = ""
		uri = URI.parse("#{endpoint}")
		@http = HTTP::Client.new uri
		@async = false

		response = Halite.post("#{endpoint}/_open/auth", 
			json: {
				"username" => @username,
				"password" => @password
			}
		)

		if response.status_code == 200
			@jwt = JSON.parse(response.body)["jwt"].to_s
		elsif response.status_code == 404
			puts "Warning! It looks like you are using a passwordless configuration"
		else 
			puts "Error #{response.status_code} #{response.status_message}"
		end
	end

	def database(name : String)
		Database.new(self, name)
	end

	def get(url : String)
		response = Halite.get(@endpoint + url, headers: headers)
		JSON.parse(response.body)
	end

	def post(url : String, body : Hash(String, Bool | NamedTuple(val: String) | String))
		response = Halite.post(@endpoint + url, headers: headers, json: body)
		JSON.parse(response.body)
	end
	  
	# def post(url : String, body : String)
	# 	response = Halite.post(url, headers: headers, json: body.to_json)
	# 	JSON.parse(response.body)
	# end
	  
	def post(url : String)
		response = @http.post(@endpoint + url, headers: headers)
		JSON.parse(response.body)
	end
	  
	def patch(url : String, body : Hash | Array)
		response = @http.patch(@endpoint + url, headers: headers, body: body.to_json)
		JSON.parse(response.body)
	end
	  
	def patch(url : String, body : String)
		response = @http.patch(@endpoint + url, headers: headers, body: body)
		JSON.parse(response.body)
	end
	  
	def delete(url : String)
		response = Halite.delete(@endpoint + url, headers: headers)
		response.body == "" ? {"code" => response.status_code} : JSON.parse(response.body)
	end
	  
	def delete(url : String, body : Hash)
		response = Halite.delete(@endpoint + url, headers: headers, json: body)
		JSON.parse(response.body)
	end
	  
	def put(url : String, body : Hash(String, String))
		response = Halite.put(@endpoint + url, headers: headers, json: body)
		JSON.parse(response.body)
	end
	  
	def put(url : String, body : String)
		response = @http.put(@endpoint + url, headers: headers, body: body)
		JSON.parse(response.body)
	end
	  
	def head(url : String)
		response = @http.head(@endpoint + url, headers: headers)
		JSON.parse(response.body)
	end
	  
	private def headers
		if @async
			headers = { "Authorization": "bearer #{@jwt}", "x-arango-async": "true" }
		else
			headers = { "Authorization": "bearer #{@jwt}"}
		end
	end
end