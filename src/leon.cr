require "./Leon/*"
require "./Leon/ORM/*"

module Leon
	VERSION = "0.1.2"

  	CONNECTION = Connection.new

	def self.connection
		Connection
	end

	def self.configuration
		yield Connection
	end
end
