ARG IMAGE_TAG=latest
FROM linuxserver/openssh-server:${IMAGE_TAG}

RUN apk add --no-cache sudo

# Pre-configure environment variables for user access
ENV PUID=${PUID:-1000}
ENV PGID=${PGID:-1000}
ENV SUDO_ACCESS=${SUDO_ACCESS:-true}
ENV USER_NAME=${USER_NAME:-admin}
ENV USER_PASSWORD=${USER_PASSWORD:-passwordABCD}
ENV PASSWORD_ACCESS=${PASSWORD_ACCESS:-false}
