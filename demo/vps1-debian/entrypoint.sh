#!/bin/sh

# Ensure /run/sshd exists
mkdir -p /run/sshd

# Setup SSH keys
mkdir -p ~/.ssh
chmod 700 ~/.ssh

for pub_file in /keys/*.pub; do
    cat "$pub_file" >> ~/.ssh/authorized_keys
done
chmod 600 ~/.ssh/authorized_keys

# Start SSH server
/usr/sbin/sshd -D