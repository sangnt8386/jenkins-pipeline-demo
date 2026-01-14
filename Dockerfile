FROM python:3.7-buster

# Cài đặt các thư viện để hỗ trợ build thư viện Python
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Nâng cấp pip lên bản mới nhất để xử lý wheel tốt hơn
RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
CMD ["python", "app.py"]
