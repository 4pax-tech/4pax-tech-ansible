FROM python:3.14-slim

WORKDIR /app
RUN apt update && apt install -y \
    ssh

RUN pip install --no-cache-dir ansible

COPY . .
