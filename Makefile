lint:
	@uv run ruff check --fix --unsafe-fixes

format: lint
	@uv run ruff format
