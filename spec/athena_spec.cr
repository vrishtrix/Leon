require "./spec_helper"

client = Athena::Client.new("http://localhost:8529", "root", "root01")
database = client.database("test_arangocr")

describe Athena do
	it "Should return the right db name" do
		database.current["result"]["name"].should eq("test_arangocr")
	end

	it "Should create the collection" do
		demo = database.collection("demo")
		demo.should be_a(Athena::Collection)
	end

	it "Should Insert a value" do
		demo = database.collection("demo")
		obj = demo.document.create({"hello" => "world"})
		obj["_id"].should be_a(JSON::Any)
	end

	it "Should read all documents" do
		demo = database.collection("demo")
		demo.all_documents["result"].size.should eq 1
	end

	it "Should run AQL query" do
		aql = database.aql
		cursor = aql.cursor({
			"query" => "FOR d IN demo RETURN d",
			"count" => true,
		})
		cursor["count"].should eq 1
	end

	it "Should run AQL query WITH bindVars" do
		aql = database.aql
		cursor = aql.cursor({
			"query"    => "FOR d IN demo FILTER d.hello == @val RETURN d",
			"bindVars" => {val: "world"},
			"count"    => true,
		})
		cursor["count"].should eq 1

		cursor = aql.cursor({
			"query"    => "FOR d IN demo FILTER d.hello == @val RETURN d",
			"bindVars" => {val: "you"},
			"count"    => true,
		})
		cursor["count"].should eq 0
	end
end

Spec.after_suite { database.delete }