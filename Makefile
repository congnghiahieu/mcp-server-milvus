IMAGE_USER ?= hieucien
IMAGE_NAME ?= mcp-server-milvus
IMAGE_REPO ?= $(IMAGE_USER)/$(IMAGE_NAME)
IMAGE_VERSION ?= 0.1.1-patched-v3
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
