FROM alpine:latest

# Install OpenSSH
RUN apk add --no-cache openssh

# Configure SSH
RUN ssh-keygen -A && \
    mkdir -p /run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Create .ssh directory for root
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Add authorized SSH key
RUN echo /keys/id_ed25519_root.pub > /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && \
    chown -R root:root /root/.ssh

# Set root password
RUN echo 'root:password5678' | chpasswd

# Expose SSH port
EXPOSE 2222

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D", "-e"]
