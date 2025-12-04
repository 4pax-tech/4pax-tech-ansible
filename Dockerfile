FROM python:3.14-slim

WORKDIR /app
RUN apt update && apt install -y \
    ssh \
    sshpass

RUN pip install --no-cache-dir ansible passlib

COPY scripts/ansible-entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

COPY inventories/ ./inventories
COPY roles/ ./roles
COPY basic_setup.yml ./basic_setup.yml
COPY ansible.cfg ./ansible.cfg


