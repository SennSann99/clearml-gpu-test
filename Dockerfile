FROM python:3.10-slim

# OS dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

CMD ["python", "main.py"]