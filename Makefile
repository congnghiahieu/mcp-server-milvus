IMAGE_USER ?= hieucien
IMAGE_NAME ?= mcp-server-milvus
IMAGE_REPO ?= $(IMAGE_USER)/$(IMAGE_NAME)
IMAGE_VERSION ?= 0.1.1-patched-v4
IMAGE ?= $(IMAGE_REPO):$(IMAGE_VERSION)

lint:
	@uv run ruff check --fix --unsafe-fixes

format: lint
	@uv run ruff format

build:
	@docker buildx build --cache-from type=registry,ref=$(IMAGE_REPO):cache -t $(IMAGE) --cache-to type=registry,ref=$(IMAGE_REPO):cache,mode=max -f Dockerfile .
	@echo "Built image: $(IMAGE)"

push:
	@docker push $(IMAGE)
	@echo "Pushed image: $(IMAGE)"

export MCP_TRANSPORT_MODE ?= streamable-http
export MCP_LOG_OUTPUT ?= console
export MCP_LOG_LEVEL ?= INFO
export MILVUS_URI ?= http://localhost:30006
export MILVUS_DB ?= default
export FASTMCP_HOST ?= 0.0.0.0
export FASTMCP_PORT ?= 7070
export FASTMCP_DEBUG ?= false
export FASTMCP_LOG_LEVEL ?= INFO

run:
	@cd src/mcp_server_milvus && python3 server.py
