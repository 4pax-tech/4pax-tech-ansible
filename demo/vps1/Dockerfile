ARG IMAGE_TAG=latest
FROM linuxserver/openssh-server:${IMAGE_TAG}

# Pre-configure environment variables for root access
ENV PUID=${PUID:-0}
ENV PGID=${PGID:-0}
ENV SUDO_ACCESS=${SUDO_ACCESS:-true}
ENV USER_NAME=${USER_NAME:-root_user}
ENV USER_PASSWORD=${USER_PASSWORD:-password5678}
ENV PASSWORD_ACCESS=${PASSWORD_ACCESS:-false}
