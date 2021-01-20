require "json"

module Leon
	module ORM
		module Persistence
			macro __process_persistence

				def save
					begin
						if _key
							# @updated_at = Time.now
							# Update

							unless self.updated_at.nil?
								self.updated_at = Time.utc
							end

							puts "Key exists"
						else
							unless @@database.nil?
								attributes = self.attributes
								attributes.delete(:_key)

								obj = self.collection.document.create(
									Hash(String, String | Array(String) | Int32 | Nil).from_json(attributes.to_json)
								)

								self._key = obj["_key"].to_s

								return self.attributes
							end
						end

						return false
					rescue exception
						puts exception
						return false
					end
				end

				def delete
					begin
						unless @@database.nil?
							# TODO: Check for soft deletes
							obj = self.collection.document.delete(self._key.as(String))
							return true
						end
						return false
					rescue exception
						puts exception
						return false
					end
				end

				def restore
				end

				def force_delete
					begin
						unless @@database.nil? && self._key.as(String).nil?
							# Check if ID is set
							obj = self.collection.document.delete(self._key.as(String))
							return true
						end
						return false
					rescue exception
						puts exception
						return false
					end
				end
			end
		end
	end
end
