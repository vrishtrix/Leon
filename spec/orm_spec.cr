require "./spec_helper"

# client = Leon::Client.new("http://localhost:8529", "root", "root01")
# database = client.database("test_arangocr")

# collection = database.collection("demo")

class User < Leon::ORM::Model
	collection "users"
	timestamps true

	attribute name : String
	attribute age : Int32
	attribute weapons : Array(String) = [] of String
end

User.generate

user = User.new name: "Test"
user.save

class Token < Leon::ORM::Model
	collection "tokens"
	timestamps false

	attribute name : String
end

Token.generate

token = Token.new name: "Test"
token.save

user.name = "Ted"
user.save

# User.find "2591281"
