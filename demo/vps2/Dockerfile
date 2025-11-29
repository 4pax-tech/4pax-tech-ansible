FROM alpine:latest

# Install OpenSSH
RUN apk add --no-cache openssh shadow

# Create a non-root user
RUN useradd -m -s /bin/ash user && \
    usermod -aG root user

# Set a password for the user
RUN echo 'user:passwordABCD' | chpasswd

# Configure SSH
RUN ssh-keygen -A && \
    mkdir -p /run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Add authorized SSH key
RUN mkdir -p /home/user/.ssh && \
    chmod 700 /home/user/.ssh && \
    chown user:user /home/user/.ssh
RUN echo /keys/id_ed25519_user.pub > /home/user/.ssh/authorized_keys && \
    chmod 600 /home/user/.ssh/authorized_keys && \
    chown user:user /home/user/.ssh/authorized_keys

# Expose SSH port
EXPOSE 2222

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D", "-e"]
