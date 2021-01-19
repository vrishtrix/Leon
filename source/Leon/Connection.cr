# module Leon
# 	class Connection

# 		property database : Leon::Database
# 		property client : Leon::Client

# 		def initialize(
# 			@endpoint : String,
# 			@username : String,
# 			@password : String,
# 			@database : String
# 		)
# 			@@client = Leon::Client.new @endpoint, @username, @password
# 			@@database = @@client.database(@database)
# 		end
# 	end
# end
