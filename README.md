# VPS Security Setup with Ansible

This Ansible project configures a VPS with security best practices recommended by OVHcloud.

## Features

- **System Updates**: Updates `apt` cache and upgrades packages.
- **Essential Tools**: Installs `curl`, `wget`, `git`, `vim`, `htop`, `ufw`, `fail2ban`.
- **User Management**:
  - Creates a new user with `sudo` privileges.
  - Adds your local public key (`~/.ssh/id_rsa.pub`) to the new user's authorized keys.
- **SSH Hardening**:
  - Changes default SSH port (default: 5022).
  - Disables root login.
  - Disables password authentication.
  - Enforces public key authentication.
- **Firewall (UFW)**:
  - Denies incoming traffic by default.
  - Allows outgoing traffic.
  - Allows SSH on the new custom port.
  - Enables UFW.
- **Fail2Ban**:
  - Installs and configures Fail2Ban.
  - Enables SSH jail with custom configuration.

## Usage

1.  **Install Ansible**: Ensure Ansible is installed on your local machine.
2.  **Update Inventory**: Edit `inventory/hosts` and add your VPS IP address. An example is provided in the file `inventory/example.hosts`.
3.  **Configure Variables**: Check `site.yml` to customize variables like `ssh_port` and `new_user`.
4.  **Run Playbook**:
    ```bash
    ansible-playbook site.yml
    ```
    *Note: For the first run, if you are connecting as root, you might need to add `-u root` if not specified in inventory.*

## Requirements

- Target VPS running Debian/Ubuntu (uses `apt`).
- SSH access to the target VPS.
