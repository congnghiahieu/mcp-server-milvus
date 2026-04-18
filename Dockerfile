FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONPATH="/app/" \
    LANG=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=1 \
    MCP_TRANSPORT_MODE=stdio \
    MCP_LOG_OUTPUT=console \
    MCP_LOG_LEVEL=INFO \
    MILVUS_URI=http://localhost:19530 \
    MILVUS_TOKEN= \
    MILVUS_DB=default \
    FASTMCP_HOST=0.0.0.0 \
    FASTMCP_PORT=8000 \
    FASTMCP_LOG_LEVEL=INFO

WORKDIR /app

COPY ./pyproject.toml /app/pyproject.toml
COPY ./uv.lock /app/uv.lock
RUN uv sync --frozen --no-dev --no-install-project --no-editable

COPY src/mcp_server_milvus/server.py /app/server.py

EXPOSE 8000

ENTRYPOINT ["python"]

CMD ["server.py"]
