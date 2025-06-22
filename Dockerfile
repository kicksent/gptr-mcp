FROM python:3.11-slim

WORKDIR /app

# Install system dependencies including curl for health checks
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Copy pyproject.toml first for better Docker layer caching
COPY pyproject.toml .
RUN uv sync --no-dev

# If there's a requirements.txt, install it as fallback with --system flag
COPY requirements.txt .
RUN uv pip install --system -r requirements.txt

# Copy application code
COPY . .

# Set environment variables for Docker
ENV MCP_TRANSPORT=streamable-http
ENV DOCKER_CONTAINER=true
ENV PYTHONUNBUFFERED=1

# Expose the port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run the server with uv
CMD ["uv", "run", "server.py"] 