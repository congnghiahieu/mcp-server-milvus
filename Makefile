IMAGE_USER ?= hieucien
IMAGE_NAME ?= mcp-server-milvus
IMAGE_VERSION ?= 0.1.1-patched-v1
IMAGE ?= $(IMAGE_USER)/$(IMAGE_NAME):$(IMAGE_VERSION)

lint:
	@uv run ruff check --fix --unsafe-fixes

format: lint
	@uv run ruff format

build:
	@docker build -t $(IMAGE) -f Dockerfile .
	@echo "Built image: $(IMAGE)"

push:
	@docker push $(IMAGE)
	@echo "Pushed image: $(IMAGE)"
