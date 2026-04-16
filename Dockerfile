# 軽量なPythonベースイメージを使用
FROM python:3.10-slim

# uvを公式のバイナリからコピーしてインストール（これが一番早くて確実です）
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 作業ディレクトリの設定
WORKDIR /app

# パッケージ定義ファイルをコピー
COPY pyproject.toml uv.lock ./

# uvを使って依存関係をインストール（仮想環境 .venv が作られます）
RUN uv sync --frozen

# アプリケーションのコードをコピー
COPY . .

# ★重要: 仮想環境のPATHを通し、ClearML AgentがこのPythonをデフォルトで使うようにする
ENV PATH="/app/.venv/bin:$PATH"

# デフォルトの実行コマンド（手元でテストする用）
CMD ["python", "main.py"]