start-ansible:
	docker compose up -d --build ansible

stop-ansible:
	docker compose down ansible


start-demo-vps:
	docker compose up -d --build vps1 vps2 vps3

stop-demo-vps:
	docker compose down vps1 vps2 vps3

start-demo: start-ansible start-demo-vps

stop-demo: stop-ansible stop-demo-vps

check-inventory:
	docker exec ansible ansible-inventory --list
	
ping-all:
	docker exec ansible ansible all -m ping

ping-raw:
	docker exec ansible ansible all -m raw -a "echo pong"

setup-demo:
	mkdir -p ssh_keys
	ssh-keygen -t ed25519 -f ssh_keys/id_ed25519_root -N "" -C "root_key"
	ssh-keygen -t ed25519 -f ssh_keys/id_ed25519_user -N "" -C "user_key"

clean-demo:
	rm -rf ssh_keys