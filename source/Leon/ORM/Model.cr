require "active-model"

require "./Error"
require "./Settings"
require "./Collection"
require "./Persistence"

module Leon
	module ORM
		class Model < ActiveModel::Model

			include Leon::ORM::Settings
			include Leon::ORM::Collection
			include Leon::ORM::Persistence
			include ActiveModel::Callbacks

			macro inherited
				__process_collection
				__process_persistence

				@@db_collection = ""
				@@db_timestamps = false

				def self.collection(collection : String)
					@@db_collection = collection
				end

				def self.db_collection
					@@db_collection
				end

				def self.timestamps(timestamps : Bool)
					@@db_timestamps = false
				end

				def self.db_timestamps
					@@db_timestamps
				end

				def class_name
					"{{@type.name.id}}".downcase
				end
			end

			def initialize(@args = {} of String => (Array(String) | JSON::Any | String))
			end

			def self.create(args = {} of String => (Array(String) | JSON::Any | String))
				self.new(**args)
			end

			def self.generate
			end

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

			def fresh
			end

			def refresh
			end

			def replicate
			end

			def is
			end
		end
	end
end
