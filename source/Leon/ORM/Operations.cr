module Leon
	module ORM
		module Operations
			macro __process_operations

				def self.all
				end

				def self.find(id : String)
					puts "Leon::Model::Find for Model #{id}"
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
