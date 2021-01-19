module Leon
	module ORM
		module Collection
			macro collection(name)
				{% SETTINGS[:collection] = name.id %}
			end

			macro __process_collection
				{% name_space = @type.name.gsub(/::/, "_").downcase.id %}
				{% collection = SETTINGS[:collection] || name_space + "s" %}


				@@collection = "{{collection}}"
				@@db_collection = ""

				def self.collection
					@@collection
				end

				def self.db_collection
					@db_collection
				end

				def _key
					_key
				end
			end
		end
	end
end
