require "json"
require "./Error"
require "./Settings"
require "./Collection"
require "./Attributes"
require "./Persistence"

class Leon::ORMDocument
	include ORMAttributes
	include ORMSettings
	include ORMCollection
	include ORMPersistence

	@errors = [] of Leon::ORMError

	def errors
		@errors
	end

	macro inherited
		__process_collection
		__process_attributes
		__process_persistence
	
		def inspect(io)
			sts = [] of String
			sts << " _id: #{self._id.nil? ? "nil" : self._id.inspect}"
			attributes.each do |attribute_name, attribute_value|
			next if attribute_name == "_id"
				sts << " #{attribute_name}: #{attribute_value.nil? ? "nil" : attribute_value.inspect}"
			end
			io << "#{self.class} {#{sts.join(",")}}"
		end
	end

	def initialize(**args : Object)
		set_attributes(args.to_h)
	end
	  
	    
	def initialize(args : Hash(Symbol | String, Leon::ORMDatabaseTypes::Any | Nil ))
		set_attributes(args)
	end

	def initialize
	end
end