# Leon
Leon is an open source ArangoDB Client driver and ORM for the Crystal Language.

## Requirements

- Crystal Language 0.35.0
- ArangoDB 3.4 or Higher

## Installation

```
dependencies:
	leon:
		github: ForetagInc/Leon
```

## Usage

```ruby
require "leon"

client = Leon::Client.new("http://localhost:8529", "root", "")
database = client.database("database")

# Async (https://www.arangodb.com/docs/stable/http/async-results-management.html)
client.async = true
```