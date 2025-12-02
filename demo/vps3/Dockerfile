FROM alpine:latest

# Install OpenSSH
RUN apk add --no-cache openssh shadow sudo

# Create a non-root user
RUN useradd -m -s /bin/ash user && \
    usermod -aG root user

# Set a password for the user
RUN echo 'user:password1234' | chpasswd

# Configure SSH
RUN ssh-keygen -A && \
    mkdir -p /run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 2222

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D", "-e"]
