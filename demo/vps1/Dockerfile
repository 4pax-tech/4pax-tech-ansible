FROM alpine:latest

# Install OpenSSH
RUN apk add --no-cache openssh

# Enable SUID bit on su (to avoid 'su: must be suid to work properly')
RUN chmod u+s /bin/su

# Set a password for the user and for root
RUN echo 'root:password_root' | chpasswd

# Configure SSH
RUN ssh-keygen -A && \
    mkdir -p /run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config


# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose SSH port
EXPOSE 2222

# Start SSH daemon via entrypoint
CMD ["/entrypoint.sh"]
