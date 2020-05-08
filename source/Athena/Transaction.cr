require "./client"

class Athena::Transaction
	@client : Athena::Client

	getter client

	def initialize(@client, @database : String); end

	def execute(params : Hash)
		@client.post("/_db/#{@database}/_api/transaction", params)
	end
end