FROM debian:latest

# Install OpenSSH
RUN apt-get update && apt-get install -y \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir -p /run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Create .ssh directory for root
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Add authorized SSH key
RUN echo /keys/id_ed25519_root.pub > /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && \
    chown -R root:root /root/.ssh

# Set root password for initial access
RUN echo 'root:passwordXYZ' | chpasswd

# Expose SSH port
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D", "-e"]