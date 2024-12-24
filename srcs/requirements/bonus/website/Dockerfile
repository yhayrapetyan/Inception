FROM debian:buster

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/app

COPY /tools/public/index.html .
COPY /tools/public/style.css .
COPY /tools/public/cool.gif .
COPY /tools/server.py .

EXPOSE 8000

CMD ["python3", "server.py"]
