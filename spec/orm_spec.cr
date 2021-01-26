require "./spec_helper"

Leon.configuration do | config |
	config.password = "root01"
	config.database = "test_arangocr"
end

arango = Leon::Connection.new

class User < Leon::ORM::Model
	collection "accounts"
	timestamps
	soft_deletes

	attribute name : String
	attribute email : String
	attribute age : Int32
	attribute weapons : Array(String) = [] of String
end

puts User.where({
	"email" => "chirub@foretag.co"
})

# user = User.find "394155"
# user.name = "Chiru B 2"
# user.age = 35
# user.save!

# users = User.where do
# end

# puts users

# user = User.new name: "Joe Lester", age: 25, weapons: ["knife", "gun"]
# user.save

# user2 = User.new name: "Moe Lester", age: 30, weapons: ["chainsaw"]
# user2.save

# user2.delete

# class User < Leon::ORM::Model
# 	# collection "users"
# 	# timestamps true

# 	attribute name : String
# 	attribute age : Int32
# 	attribute weapons : Array(String) = [] of String
# end

# user = User.new name: "Test", age: 25
# user.save

# class Token < Leon::ORM::Model
# 	attribute name : String
# end

# token = Token.new name: "Test"
# token.save

# Token.find "12121"

# user.name = "Ted"
# user.save

# User.find "2591281"
