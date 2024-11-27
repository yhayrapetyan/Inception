FROM python:3.11-slim

WORKDIR /home/app

COPY /tools/public/index.html .
COPY /tools/public/style.css .
COPY /tools/public/cool.gif .
COPY /tools/server.py .

EXPOSE 8000

CMD ["python", "server.py"]
