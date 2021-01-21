module Leon
	module ORM
		module Operations
			macro __process_operations

				def self.all
				end

				def self.find(id : String)
					begin
						unless @@database.nil?
							obj = collection.document.get(id)

							attributes = Hash(String, String | Array(String) | Int32 | Nil | Bool | Int64 | Float32 | Float64).from_json(obj.to_json)

							return Nil if attributes.has_key?("code")

							instance = self.new
							instance.assign_attributes_from_json(obj.to_json)

							return instance

							return Nil
						end
					rescue exception
						puts exception
						return Nil
					end
				end

				def self.where
					puts "where"
				end

				def self.destroy
				end

			end
		end
	end
end
