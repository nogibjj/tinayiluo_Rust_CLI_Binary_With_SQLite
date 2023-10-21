# Display Rust command-line utility versions
rust-version:
	@echo "Rust command-line utility versions:"
	rustc --version              # Rust compiler
	cargo --version              # Rust package manager
	rustfmt --version            # Rust code formatter
	rustup --version             # Rust toolchain manager
	clippy-driver --version      # Rust linter

# Format code using rustfmt
format:
	cargo fmt --quiet

# Run clippy for linting
lint:
	cargo clippy --quiet

# Run tests
test:
	cargo test --quiet

# Build and run the project
run:
	cargo run

# Build release version
release:
	cargo build --release

# Install Rust toolchain if needed
install:
	# Install if needed
	# @echo "Updating rust toolchain"
	# rustup update stable
	# rustup default stable 

# Run all formatting, linting, and testing tasks
all: format lint test run

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

# Generate and push changes to GitHub
generate_and_push:
	@if [ -n "$$(git status --porcelain)" ]; then \
		git config --local user.email "action@github.com"; \
		git config --local user.name "GitHub Action"; \
		git add .; \
		git commit -m "Add query log"; \
		git push; \
	else \
		echo "No changes to commit. Skipping commit and push."; \
	fi
