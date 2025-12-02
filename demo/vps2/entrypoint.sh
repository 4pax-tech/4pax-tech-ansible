#!/bin/sh
set -e

# Create .ssh directory
mkdir -p /home/user/.ssh
chmod 700 /home/user/.ssh
chown user:user /home/user/.ssh

# Copy public key from mounted volume
if [ -f /keys/id_ed25519_user.pub ]; then
    cat /keys/id_ed25519_user.pub > /home/user/.ssh/authorized_keys
    chmod 600 /home/user/.ssh/authorized_keys
    chown user:user /home/user/.ssh/authorized_keys
    echo "SSH key configured for user"
else
    echo "WARNING: /keys/id_ed25519_user.pub not found"
fi

# Start SSH daemon
exec /usr/sbin/sshd -D -e
