module Leon
	module ORM
		module Persistence
			macro __process_persistence

				def save
					# begin
					# 	if _key
					# 		@updated_at = Time.now
					# 		# Update
					# 	else
					# 		@created_at = Time.now
					# 		@updated_at = Time.now
					# 	end

					# 	return true
					# rescue ex

					# 	return false
					# end
					puts "save"
				end

				def delete
				end

				def force_delete
				end

				def restore
				end
			end
		end
	end
end
