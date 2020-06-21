require "json"
require "./Error"
require "./Settings"
require "./Collection"
require "./Attributes"
require "./Persistence"

class Athena::ORMDocument
	include Attributes
	include Settings
	include Collection
	include Persistence

	@errors = [] of Athena::ORMError

	def errors
		@errors
	end

	macro inherited
		macro finished
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
	end

	def initialize(**args : Object)
		set_attributes(args.to_h)
	end
	  
	    
	def initialize(args : Hash(Symbol | String, ArangoModel::DatabaseTypes::Any | Nil ))
		set_attributes(args)
	end

	def initialize
	end
end