# Athena
Athena is an open source ArangoDB Client and ORM for the Crystal Language

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

```
require "leon"

client = Leon::Client.new("http://localhost:8529", "root", "")
database = client.database("database")
```