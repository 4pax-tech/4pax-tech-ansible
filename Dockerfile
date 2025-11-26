FROM python:3.14-slim

WORKDIR /app
RUN apt update && apt install -y \
    ssh \
    sshpass

RUN pip install --no-cache-dir ansible

COPY . .
