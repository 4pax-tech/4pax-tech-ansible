#!/bin/sh
set -e

# Create .ssh directory
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Copy public key from mounted volume
if [ -f /keys/id_ed25519_root.pub ]; then
    cat /keys/id_ed25519_root.pub > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    chown root:root /root/.ssh/authorized_keys
    echo "SSH key configured for root"
else
    echo "WARNING: /keys/id_ed25519_root.pub not found"
fi

# Start SSH daemon
/usr/sbin/sshd -D -e &
echo "SSH daemon started"

tail -f /dev/null