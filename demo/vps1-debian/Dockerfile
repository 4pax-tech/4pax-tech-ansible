FROM debian:latest

RUN apt update && apt install -y openssh-server

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start SSH server
CMD ["/entrypoint.sh"]