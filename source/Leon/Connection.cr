module Leon
	class Connection
		class_property endpoint : String = "http://localhost:8529"
		class_property username : String = "root"
		class_property password : String = ""
		class_property database : String = "database"

		class_property client : Leon::Client | Nil
		class_property db  : Leon::Database | Nil

		def initialize
			@@client = Client.new(@@endpoint, @@username, @@password)
			@@db = @@client.as(Leon::Client).database(@@database)
		end
	end
end
