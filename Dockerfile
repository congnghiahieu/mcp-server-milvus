FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    MILVUS_URI=http://localhost:19530 \
    MILVUS_TOKEN= \
    MILVUS_DB=default \
    FASTMCP_HOST=0.0.0.0 \
    FASTMCP_PORT=8000 \
    FASTMCP_LOG_LEVEL=INFO

WORKDIR /app

COPY ./pyproject.toml /app/pyproject.toml
COPY ./uv.lock /app/uv.lock
RUN uv sync --frozen --no-dev --no-editable --no-install-project

COPY src/mcp_server_milvus/server.py /app/server.py

EXPOSE 8000

ENTRYPOINT ["uv", "run"]

CMD ["server.py"]
