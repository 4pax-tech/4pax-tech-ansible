# VPS Security Setup with Ansible

This Ansible project configures multiple VPS with security best practices.
Some of them are directly recommended by cloud providers such as, for example, [OVHcloud](https://help.ovhcloud.com/csm/en-gb-vps-security-tips?id=kb_article_view&sysparm_article=KB0047706).

This project shows strategies that can be deployed on Debian/Ubuntu hosts and Alpine hosts.
It includes a demo configuration to show how one could use this project for its own purpose. The demo rely on VPS emulated using Docker containers.


## Features
Some 
- **Bootstrap**: Ensure targets have Python installed to be configurable by Ansible.
- **System Updates**: Updates `apt` or `apk` cache and upgrades packages.
- **Essential Tools**: Installs common useful packages (git, curl, vim, sudo).
- **User Management**:
  - Creates a new user with `sudo` privileges.
  - Adds local public key to the new user's authorized keys.
- **SSH Hardening**:
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

## How to use
### Production mode
Since Ansible needs to be installed locally, it was decided to pack this up in a Docker container which responsability is to manage the targets configuration.

To use this project for a specific configuration, one should:
1.  **Install Docker**: Ensure Docker is installed on your local machine.
2.  **Update Inventory**: Edit `inventories/production-bootstrap` directory by adding files like the ones provided in the demo directory `inventories/demo-bootstrap/hosts.yml`. Also edit `inventories/production` directory by adding files like the ones provided in the demo directory `inventories/demo/hosts.yml` and
3.  **Configure Variables**: Check corresponding examples in `inventories/demo-bootstrap/group_vars` and `inventories/bootstrap/host_vars` to customize variables like `ssh_port` and `new_user`.
4.  **Define secrets**: Define secrets in a `secrets.yml` file.
5.  **Run Playbook**:
    ```bash
    make start ansible
    make configure-vps
    ```
    *Note: For the first run, if you are connecting as root, you might need to add `-u root` if not specified in inventory.*

*Note 1:* Since the VPS setup change how to connect to the targets, we propose to use a two inventory strategy to define the VPS that have not been configured once yet and the ones already bootstraped.


*Note 2:* An example on how to generate SSH keys is provided through the following command (see the `Makefile`for details):
```bash
make setup-demo
```

### Demo mode
The demo mode, starts VPS emulated as Docker containers and execute the playbooks on them.
First, to setup SSH keys, use the following command:
```bash
make setup-demo
```

Then, execute the following command to start all the Docker container services:
```bash
make restart-demo
```
At this step, a password used to encrypt the secrets is asked. Enter whatever you want but record it since it will be asked when the playbook is executed.
At this step, you should be able to connect to each emulated VPS through SSH. For example, the following command must succeed:
```bash
docker exec -it ansible ssh -i /keys/id_ed25519_user -p 2222 user@vps2
```

Finally, execute the following command to configure the VPS:
```bash
make configure-vps-demo
```

At this step, the VPS is set up and the previous SSH command should return an error like:
```bash
ssh: connect to host vps2 port 2222: Connection refused
```
Using the new deployed SSH configuration, the following command must now work and validate that the SSH configuration has been changed:
```bash
docker exec -it ansible ssh -i /keys/id_ed25519_deploy deploy@vps2
```

Now that the VPS are configure, it is possible to configure them again with the new SSH credentials using:
```bash
make configure-vps-demo
```

Feel free to add more hosts in the `inventories/demo-bootstrap/hosts.yml` and `inventories/demo/hosts.yml` files, for example virtual machines like the ones commented out.

## Requirements

- Docker running locally
