ARG IMAGE_TAG=latest
FROM linuxserver/openssh-server:${IMAGE_TAG}

RUN apk add --no-cache sudo

# Pre-configure environment variables for password access
ENV PUID=${PUID:-1000}
ENV PGID=${PGID:-1000}
ENV PASSWORD_ACCESS=${PASSWORD_ACCESS:-true}
ENV SUDO_ACCESS=${SUDO_ACCESS:-true}
ENV USER_NAME=${USER_NAME:-debian}
ENV USER_PASSWORD=${USER_PASSWORD:-password1234}
