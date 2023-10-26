## Rust CLI Binary with SQLite
[![Rust CI/CD Pipeline](https://github.com/nogibjj/tinayiluo_Rust_CLI_Binary_With_SQLite/actions/workflows/ci.yml/badge.svg)](https://github.com/nogibjj/tinayiluo_Rust_CLI_Binary_With_SQLite/actions/workflows/ci.yml)

### Architectural Diagram

![SQLite Diagram drawio (1)](https://github.com/nogibjj/tinayiluo_sqlite_lab/assets/143360909/6ddfa32e-d164-40fd-9413-8d0e1654bbc1)

### Goal

This project delivers a comprehensive Data Extraction, Transformation, Loading (ETL) tool, alongside Querying (CRUD) capabilities, all developed using Rust. The process entails initializing a new Rust project with `cargo init` and installing Rust dependencies through `Cargo.toml` using `cargo build`. Notably, Github Copilot was employed to aid the transition from Python to Rust. This conversion was meticulously crafted to ensure adherence to Rust's syntax, robust error handling, and full utilization of Rust's unique features. 

This toolkit offers a suite of functions for ETL operations on datasets, facilitating queries on a SQLite database. It comprehensively covers CRUD (Create, Read, Update, Delete) operations, logging all queries to a Markdown file, query_log.md, to aid in the tracking and analysis of executed commands.

The operational workflow includes running a Makefile to perform tasks such as installation (`make install`), testing (`make test`), code formatting (`make format`) with Python Black, linting (`make lint`) with Ruff, and an all-inclusive task (`make all`). This automation streamlines the data analysis process and enhances code quality.

To cap it off, the project produces an optimized Rust binary, which is available as a GitHub Actions artifact, ready for download.

Here is my video demo showing a clear, concise walkthrough and demonstration of my CLI binary:  [link]

### Workflow Overview

```
- Rust Initiation and Dependencies Installation (`Cargo init`, `Cargo.toml`, `Cargo build`)

- Github Copilot Translation from Python to Rust

* Proper usage of Rust syntax

* Effective error handling in Rust

* Implementation of Rust's unique features

- ETL-Query:  [E] Extract a dataset from URL, [T] Transform, [L] Load into SQLite Database and [Q] Query

* [E] The extract function downloads data from a specified URL and saves it to a local file.

* [T][L] The transform_load function reads a CSV dataset and inserts its records into a SQLite database after performing necessary table operations. It creates a table named AirlineSafetyDB with specific columns.

* [Q] The query function writes and executes SQL queries on the SQLite database to analyze and retrieve insights from the data. The queries can perform CRUD (create, read, update, delete) operations. 

- Logging:  The log_query function appends SQL queries to a log file. By logging the queries into a Markdown file named `query_log.md`, it facilitates tracking and analysis of executed queries.

- GitHub Actions: A workflow file that tests, builds, and lints the Rust code.

- Optimized Rust Binary: Generates an optimized Rust binary as a GitHub Actions artifact that can be downloaded.
```

### Preperation

+ I forked rust-new-project-template.

+ I chose the Airline safety dataset `airline-safety.csv` from Github.

### Dataset Background

The dataset `airline-safety.csv` originates from the Aviation Safety Network and consolidates safety-related information for 56 airlines in a CSV file. It encompasses data on available seat kilometers flown every week and provides a detailed record of incidents, fatal accidents, and fatalities, each segregated into two time frames: 1985–1999 and 2000–2014.

#### [Resources](https://github.com/fivethirtyeight/data/tree/master/airline-safety) 

### Project Description 

Step 1: Rust Initiation using `cargo init`

initialize a new Rust project by running ‘cargo init` inside the directory, it will set up a new Rust project by:

* Creating a `Cargo.toml` file, which contains configuration data, dependencies, and other metadata about the Rust project.

* Creating a `src` directory with a main.rs file for binary projects or lib.rs for libraries.

* Generating a `.gitignore` file if the directory is not inside an existing git repository. 

Step 2: Rust Dependencies Installation using `cargo build`

In `Cargo.toml` specify metadatas and dependencies

* Project Metadata: It provides metadata about the Rust package, such as its name, version, authors, and edition.

```
[package]
name = "tina_yi_sqlite"
version = "0.1.0"
edition = "2021"
```

* Dependencies: It lists external packages (also known as "crates") that the project depends on. This allows Cargo to automatically fetch and build these dependencies when compiling the project.

```
[dependencies]
reqwest = { version = "^0.11", features = ["blocking"] }
rusqlite = "^0.29"
csv = "^1.0"
assert_cmd = "^2.0"
predicates = "0.9"
```

The Following Steps Are Performed Using `Github Copilot` Translation From Python to Rust

Step 3: src `lib.rs`: 

The `lib.rs` file provides a set of functions that work in tandem to extract data from a URL, store it as a local CSV file, load this data into a SQLite database, and provide querying capabilities, with all executed queries being logged for future reference.

Step 4: src `main.rs`:

The `main.rs` file provides a command-line interface (CLI) for users to execute three main actions (ETL-Query) related to a dataset: extracting it from a URL, transforming and loading it into a SQLite database , and executing SQL queries against the database.

Step 5: tests `etl.test.rs`:

The `etl_tests.rs` file provides unit tests for the core ETL functions of the tina_yi_sqlite crate, helping ensure the integrity and correctness of the crate's functionality.

Step 6: `Makefile`:

The Makefile provides a set of tasks to automate various aspects of developing, testing, and managing a Rust project.

Custom tasks related to the database:

* extract: Runs the extract action of the project.

* transform_load: Runs the transform_load action of the project.

* create: Executes a SQL query to insert a new record into the AirlineSafetyDB table.

* read: Executes a SQL query to select a record from the AirlineSafetyDB table.

* update: Executes a SQL query to update a specific record in the AirlineSafetyDB table.

* delete: Executes a SQL query to delete a specific record from the AirlineSafetyDB table.

```
# Custom tasks

# Example: Extract data
extract: 
	cargo run extract

# Example: Transform and Load data
transform_load:
	cargo run transform_load

# Example: Create a database entry
create:
	cargo run query "INSERT INTO AirlineSafetyDB (airline, avail_seat_km_per_week, incidents_85_99, fatal_accidents_85_99, fatalities_85_99, incidents_00_14, fatal_accidents_00_14, fatalities_00_14) VALUES ('Happy Airlines', 965346770, 1, 1, 1, 1, 1, 1);"

# Example: Read from the database
read:
	cargo run query "SELECT * FROM AirlineSafetyDB WHERE airline = 'Happy Airlines';"

# Example: Update a database entry
update:
	cargo run query "UPDATE AirlineSafetyDB SET airline='Happy Airlines', avail_seat_km_per_week=965346770, incidents_85_99=0, fatal_accidents_85_99=0, fatalities_85_99=0, incidents_00_14=0, fatal_accidents_00_14=0, fatalities_00_14=0 WHERE id=57;"

# Example: Delete a database entry
delete:
	cargo run query "DELETE FROM AirlineSafetyDB WHERE id=57;"
```

Step 7: Github Actions `ci.yml`:

The CI/CD pipeline provides a comprehensive process for building, testing, and managing this Rust project on GitHub.

Step 6: [log of successful database operations](./query_log.md)

### Optimized Rust Binary

You can find and download the uploaded artifact by going to actions and clicking on the latest workflow run.

<img width="1075" alt="Screen Shot 2023-10-22 at 10 53 45 PM" src="https://github.com/nogibjj/tinayiluo_Rust_CLI_Binary_With_SQLite/assets/143360909/c0cfb21c-4736-4fca-a012-07e18e499042">


### Video Demo: showing a clear, concise walkthrough and demonstration of the CLI binary.

- open codespaces and wait for codespaces to be built

- build: `cargo build` for dependencies installation

- extract: make extract

- transform and load: make transform_load

- query sample: you can use make create, make read, make update, or make delete to see sample CRUD Operations

- query your own: cargo run query <insert own query here>

- You can find my successful CRUD operations [here](./query_log.md)

- You can find and download the uploaded artifact by going to actions and clicking on the latest workflow run.

### Make Format, Test, Lint, All Approval Image

* Format code make format

* Lint code make lint

* Test code make test

<img width="1071" alt="Screen Shot 2023-10-22 at 10 46 38 PM" src="https://github.com/nogibjj/tinayiluo_Rust_CLI_Binary_With_SQLite/assets/143360909/8734977c-270c-49d0-a408-5249637e5acf">

<img width="965" alt="Screen Shot 2023-10-22 at 10 46 59 PM" src="https://github.com/nogibjj/tinayiluo_Rust_CLI_Binary_With_SQLite/assets/143360909/76afed36-7f4f-4ad5-af5c-686011160d07">
