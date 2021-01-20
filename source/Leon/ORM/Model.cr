require "active-model"

require "./Error"
require "./Settings"
require "./Collection"
require "./Persistence"
require "./Operations"

module Leon
	module ORM
		class Model < ActiveModel::Model

			include Leon::ORM::Settings
			include Leon::ORM::Collection
			include Leon::ORM::Persistence
			include Leon::ORM::Operations

			include ActiveModel::Callbacks

			@errors = [] of Leon::ORM::Error
			@@database = Leon::Connection.db

			macro inherited
				__process_collection
				__process_persistence
				__process_operations

				def class_name
					"{{@type.name.id}}".downcase
				end
			end

			def initialize(@args = {} of String => (Array(String) | JSON::Any | String))
			end

			def self.create(args = {} of String => (Array(String) | JSON::Any | String))
				self.new(**args)
			end

			def errors
				@errors
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
