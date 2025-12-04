.PHONY: start-ansible stop-ansible start-demo-vps stop-demo-vps start-demo stop-demo restart-demo check-inventory ping-all ping-raw setup-demo clean-demo setup-vps

ARCH := $(shell uname -m)
ifeq ($(ARCH),arm64)
    IMAGE_TAG := arm64v8-latest
else
    IMAGE_TAG := amd64-latest
endif

start-ansible:
	IMAGE_TAG=$(IMAGE_TAG) docker compose up -d --build ansible
	
stop-ansible:
	docker compose down ansible

start-demo-vps:
	IMAGE_TAG=$(IMAGE_TAG) docker compose up -d --build vps1 vps2 vps3 vps1-debian

stop-demo-vps:
	docker compose down vps1 vps2 vps3

start-demo: start-ansible start-demo-vps
	docker cp ./demo/secrets.yml ansible:/app/secrets.yml
	@test -f inventories/demo-bootstrap/group_vars/all/vault.yml || docker exec -it ansible ansible-vault encrypt --output inventories/demo-bootstrap/group_vars/all/vault.yml /app/secrets.yml
	docker exec ansible cp ./inventories/demo-bootstrap/group_vars/all/vault.yml ./inventories/demo/group_vars/all/vault.yml

stop-demo: stop-ansible stop-demo-vps

restart-demo: stop-demo start-demo

check-inventory:
	docker exec ansible ansible-inventory --list
	
ping-all:
	docker exec ansible ansible all -m ping

ping-raw:
	docker exec ansible ansible -i inventories/production all -m raw -a "echo pong"

setup-demo:
	mkdir -p ssh_keys
	ssh-keygen -t ed25519 -f ssh_keys/id_ed25519_root -N "" -C "root_key"
	ssh-keygen -t ed25519 -f ssh_keys/id_ed25519_user -N "" -C "user_key"
	ssh-keygen -t ed25519 -f ssh_keys/id_ed25519_deploy -N "" -C "deploy_key"

configure-vps-demo-boostrap:
	docker exec -it ansible ansible-playbook -i inventories/demo-bootstrap basic_setup.yml --ask-vault-pass

configure-vps-demo:
	docker exec -it ansible ansible-playbook -i inventories/demo basic_setup.yml --ask-vault-pass

configure-vps:
	@read -p "Enter inventory folder path: " INV_PATH; \
	if [ ! -d "$$INV_PATH" ]; then \
		echo "Error: folder '$$INV_PATH' does not exist."; \
		exit 1; \
	fi; \
	read -p "Enter path to secrets file: " SECRET_PATH; \
	if [ ! -f "$$SECRET_PATH" ]; then \
		echo "Error: secrets file '$$SECRET_PATH' does not exist."; \
		exit 1; \
	fi; \
	echo "Copying secrets file"; \
	docker cp "$$SECRET_PATH" ansible:/app/secrets.yml; \
	echo "Encrypting secrets file"; \
	docker exec -it ansible ansible-vault encrypt --output "$$INV_PATH"/group_vars/all/vault.yml /app/secrets.yml; \
	docker exec -it ansible ansible-playbook -i "$$INV_PATH" basic_setup.yml --ask-vault-pass

clean-demo:
	rm -rf ssh_keys