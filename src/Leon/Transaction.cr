require "./client"

class Leon::Transaction
	@client : Leon::Client

	getter client

	def initialize(@client, @database : String); end

	def execute(params : Hash)
		@client.post("/_db/#{@database}/_api/transaction", params)
	end
end