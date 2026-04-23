FROM python:3.10-slim

# OSの依存ライブラリをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 git \
    && rm -rf /var/lib/apt/lists/*

# uvのインストール
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app
COPY pyproject.toml uv.lock ./

# 依存関係のインストール（.venv が作成される）
RUN uv sync --frozen

COPY . .

# ClearML Agentがこの環境を使うようにPATHを通す
ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "main.py"]
