module Leon
	module ORM
		module Operations
			macro __process_operations

				def self.all
					# TODO: Refactor and return Array(self)
					self.collection.all_documents["result"]
				end

				def self.find(id : String) : self
					# TODO: Refactor with guards
					obj = collection.document.get(id)
					instance = self.new
					instance._key = obj["_key"].to_s
					instance.assign_attributes_from_json(obj.to_json)
					instance
				end

				def self.where(filters : Hash(String, String | Bool | Float64 | Int32 | Int64 | Array(String) | Array(Int32))) # : self | Array(self)

					query = String.build do | io |
						io << "FOR x IN #{self.get_collection}"
						io << "\n"
							io << "	FILTER "
						filters.each do | key, value |
							io << "x.#{key} == @#{key} #{key == filters.last_key? ? "" : "&& "}"
						end
						io << "\n"
						io << "	RETURN x"
					end

					puts "Query: #{query}"

					aql = self.aql
					cursor = aql.cursor({
						"query" => query,
						"bindVars": {
							email: "chirub@foretag.co"
						},
						"count": true
					})

					puts cursor["result"]

				end

				def self.destroy(id : String)
					obj = self.collection.document.delete(id)
					puts obj
					return true
				end

			end
		end
	end
end
